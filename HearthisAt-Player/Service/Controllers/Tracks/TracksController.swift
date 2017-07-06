//
//  TracksController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

protocol TracksController: Controller {
    
    func tracks(for artist: User) -> ArtistList<Track>?
    
    func loadTracks(for artist: User,
                    pageIndex: Int,
                    count: Int,
                    success: ((_ tracks: [Track], _ allTracks: ArtistList<Track>) -> Void)?,
                    failure: MethodFailure?)
}
