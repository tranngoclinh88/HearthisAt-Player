//
//  FeedApiController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import ObjectMapper

class FeedApiController: ApiController, FeedController {
 
    // MARK: Defaults
    
    private struct Defaults {
        static let pageSize = 20
    }
    
    // MARK: Properties
    
    private(set) var popularFeed = TrackFeed(kind: .popular)
    private(set) var newFeed = TrackFeed(kind: .new)
    
    // MARK: Methods
    
    func loadFeed(of kind: TrackFeed.Kind,
                  pageIndex: Int,
                  count: Int,
                  success: ((TrackFeed, [Track]) -> Void)?,
                  failure: ((Error) -> Void)?) {
        
        let parameters: [String : Any] = ["type" : kind.rawValue,
                                          "page" : pageIndex,
                                          "count": count]
        guard let request = requestBuilder.build(for: .feed,
                                                 method: .get,
                                                 parameters: parameters) else {
                                                    failure?(ControllerError.unknownMethodFailure)
                                                    return
        }
        
        // perform the request
        requestExecutor.execute(request,
                                success:
            { (request, response, data) in
                guard let data = data else {
                    failure?(ControllerError.unexpectedResponse)
                    return
                }
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String : Any]]
                    let tracks = Mapper<Track>().mapArray(JSONArray: json)
                    let feed = self.feed(for: kind)
                    
                    feed.insert(page: tracks, at: pageIndex)
                    
                    success?(feed, tracks)
                    
                } catch {
                    failure?(ControllerError.unexpectedResponse)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
    
    func loadNextPage(of feed: TrackFeed,
                      success: ((TrackFeed, [Track]) -> Void)?,
                      failure: ((Error) -> Void)?) {
        loadFeed(of: feed.kind,
                 pageIndex: feed.nextPage,
                 count: feed.pageSize ?? Defaults.pageSize,
                 success: success,
                 failure: failure)
    }
    
    // MARK: Utility
    
    func feed(for kind: TrackFeed.Kind) -> TrackFeed {
        switch kind {
        case .popular:
            return popularFeed
        case .new:
            return newFeed
        }
    }
}
