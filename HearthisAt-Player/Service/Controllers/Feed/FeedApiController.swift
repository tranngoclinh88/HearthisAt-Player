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
 
    func loadFeed(of kind: TrackFeed.Kind,
                  pageIndex: Int,
                  count: Int,
                  success: ((TrackFeed) -> Void)?,
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
                    dump(tracks)
                    
                } catch {
                    failure?(ControllerError.unexpectedResponse)
                }
        }) { (request, response, error) in
            
        }
    }
}
