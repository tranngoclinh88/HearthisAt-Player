//
//  ArtistApiController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class ArtistApiController: ApiController, ArtistController {
    
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
                    let profile = ArtistProfile(JSON: json)

//                    success?(feed, trSacks)
                    
                } catch {
                    failure?(ControllerError.unexpectedResponse)
                }
        }) { (request, response, error) in
            failure?(error)
        }
    }
}
