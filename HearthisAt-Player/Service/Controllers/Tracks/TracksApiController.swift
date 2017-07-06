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
    
    // MARK: Properties
    
    private var artistTracksMap: [String : ArtistList<Track>] = [:]
    
    // MARK: Methods
    
    func tracks(for artist: User) -> ArtistList<Track>? {
        guard let identifier = artist.permalink else { return nil }
        return artistTracksMap[identifier]
    }
    
    func loadTracks(for artist: User,
                    pageIndex: Int,
                    count: Int,
                    success: (([Track], ArtistList<Track>) -> Void)?,
                    failure: Controller.MethodFailure?) {
        
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
    
    // MARK: Utility
    
    private func createTracksIfNeeded(for artist: User, identifier: String) -> ArtistList<Track> {
        if tracks(for: artist) == nil {
            self.artistTracksMap[identifier] = ArtistList<Track>(kind: .tracks)
        }
        return tracks(for: artist)!
    }
}
