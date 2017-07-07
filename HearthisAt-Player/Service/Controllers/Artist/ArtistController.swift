//
//  ArtistController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

protocol ArtistController: Controller {
    
    /// Get the profile for an artist.
    ///
    /// - Parameter artist: The artist.
    /// - Returns: The artist profile if loaded.
    func profile(for artist: Artist) -> ArtistProfile?
    
    /// Load a profile for an artist.
    ///
    /// - Parameters:
    ///   - artist: The artist.
    ///   - success: Execution on successful method.
    ///   - failure: Execution on failed method.
    func loadProfile(for artist: Artist,
                     success: ((ArtistProfile) -> Void)?,
                     failure: MethodFailure?)
}
