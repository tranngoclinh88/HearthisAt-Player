//
//  ArtistApiController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class ArtistApiController: ApiController, ArtistController {
    
    // MARK: Properties
    
    private var artistProfileMap: [String : ArtistProfile] = [:]
    
    // MARK: Methods
    
    func loadProfile(for artist: Artist,
                     success: ((ArtistProfile) -> Void)?,
                     failure: Controller.MethodFailure?) {
        guard let username = artist.permalink else {
            failure?(ControllerError.unknownMethodFailure)
            return
        }
        
        guard let request = requestBuilder.build(for: .artist(username: username),
                                                 method: .get) else {
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
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
                    guard let profile = ArtistProfile(JSON: json) else {
                        failure?(ControllerError.unexpectedResponse)
                        return
                    }
                    
                    self.artistProfileMap[username] = profile
                    success?(profile)
                    
                } catch {
                    failure?(ControllerError.unexpectedResponse)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
    
    func profile(for artist: Artist) -> ArtistProfile? {
        guard let identifier = artist.permalink else { return nil }
        return artistProfileMap[identifier]
    }
}
