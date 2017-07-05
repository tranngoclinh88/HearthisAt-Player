//
//  TracksApiController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class TracksApiController: ApiController, TracksController {
    
    func tracks(for user: User) -> PagedResults<Track>? {
        // return loaded tracks for a user
        return nil
    }
    
    func loadTracks(for user: User,
                    page: Int,
                    count: Int,
                    success: ((PagedResults<Track>) -> Void)?,
                    failure: (Error) -> Void) {
        
    }
}
