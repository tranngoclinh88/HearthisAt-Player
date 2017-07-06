//
//  TracksApiController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import ObjectMapper

class TracksApiController: ApiController, TracksController {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let pageSize = 20
    }
    
    // MARK: Properties
    
    private var artistTracksMap: [String : TracksList] = [:]
    
    // MARK: Methods
    
    func tracks(for artist: User) -> TracksList? {
        guard let identifier = artist.permalink else { return nil }
        return artistTracksMap[identifier]
    }
    
    func loadTracks(for artist: User,
                    pageIndex: Int?,
                    count: Int?,
                    success: (([Track], TracksList) -> Void)?,
                    failure: Controller.MethodFailure?) {
        let pageIndex = pageIndex ?? 1
        let count = count ?? Defaults.pageSize
        
        guard let identifier = artist.permalink else {
            failure?(ControllerError.unknownMethodFailure)
            return
        }
        
        let parameters: [String : Any] = ["type" : ArtistList<Track>.Kind.tracks.rawValue,
                                          "page" : pageIndex,
                                          "count": count]
        guard let request = requestBuilder.build(for: .artistTracks(username: identifier),
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
                    
                    let tracksList = self.createTracksIfNeeded(for: artist, identifier: identifier)
                    tracksList.insert(page: tracks, at: pageIndex)
                    
                    success?(tracks, tracksList)
                    
                } catch {
                    failure?(ControllerError.unexpectedResponse)
                }
        }) { (request, reponse, error) in
            failure?(error)
        }
    }
    
    func loadNextPage(of tracks: TracksList,
                      success: (([Track], TracksList) -> Void)?,
                      failure: Controller.MethodFailure?) {
        loadTracks(for: tracks.artist,
                   pageIndex: tracks.nextPage,
                   count: tracks.pageSize ?? Defaults.pageSize,
                   success: success,
                   failure: failure)
    }
    
    // MARK: Utility
    
    private func createTracksIfNeeded(for artist: User, identifier: String) -> TracksList {
        if tracks(for: artist) == nil {
            self.artistTracksMap[identifier] = ArtistList<Track>(kind: .tracks, for: artist)
        }
        return tracks(for: artist)!
    }
}
