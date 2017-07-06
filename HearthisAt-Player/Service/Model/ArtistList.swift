//
//  ArtistList.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class ArtistList<T>: PagedResults<T> {
    
    // MARK: Types
    
    enum Kind: String {
        case likes = "likes"
        case playlists = "playlists"
        case tracks = "tracks"
    }
    
    // MARK: Properties
    
    let kind: Kind
    let artist: User
    
    // MARK: Init
    
    init(kind: Kind, for artist: User) {
        self.kind = kind
        self.artist = artist
    }
}
