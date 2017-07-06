//
//  TracksController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

typealias ArtistTracksList = ArtistList<Track>

protocol TracksController: Controller {    
    
    /// Get the tracks list for an artist.
    ///
    /// - Parameter artist: The artist to get tracks for.
    /// - Returns: The tracks list if loaded.
    func tracks(for artist: User) -> ArtistTracksList?
    
    /// Load a list of tracks for an artist.
    ///
    /// - Parameters:
    ///   - artist: The artist to load tracks for.
    ///   - pageIndex: The page index to load.
    ///   - count: The number of tracks to load.
    ///   - success: Execution on successful method.
    ///   - failure: Execution on failed method.
    func loadTracks(for artist: User,
                    pageIndex: Int?,
                    count: Int?,
                    success: ((_ tracks: [Track], _ allTracks: ArtistTracksList) -> Void)?,
                    failure: MethodFailure?)
    
    /// Load the next page of a tracks list.
    ///
    /// - Parameters:
    ///   - tracks: The tracks list.
    ///   - success: Execution on successful method.
    ///   - failure: Execution on failed method.
    func loadNextPage(of tracks: ArtistTracksList,
                      success: ((_ newPage: [Track], _ allTracks: ArtistTracksList) -> Void)?,
                      failure: MethodFailure?)
}
