//
//  UserProfile.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import ObjectMapper

typealias ArtistProfile = UserProfile

struct UserProfile: Mappable {
    
    private(set) var id: Int?
    private(set) var username: String?
    private(set) var permalink: String?
    private(set) var uri: String?
    private(set) var description: String?
    private(set) var geo: String?
    
    private(set) var permalinkUrl: URL?
    private(set) var thumbnailUrl: URL?
    private(set) var avatarUrl: URL?
    private(set) var backgroundUrl: URL?
    
    private(set) var trackCount: Int?
    private(set) var playlistCount: Int?
    private(set) var likesCount: Int?
    private(set) var followersCount: Int?
    private(set) var followingCount: Int?
    
    // MARK: Mappable
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.id             <- (map["id"], IntTransform())
        self.permalink      <- map["permalink"]
        self.username       <- map["username"]
        self.uri            <- map["uri"]
        self.permalinkUrl   <- (map["permalink_url"], URLTransform())
        self.thumbnailUrl   <- (map["thumb_url"], URLTransform())
        self.avatarUrl      <- (map["avatar_url"], URLTransform())
        self.backgroundUrl  <- (map["background_url"], URLTransform())
        self.description    <- map["description"]
        self.geo            <- map["geo"]
        self.trackCount     <- (map["track_count"], IntTransform())
        self.playlistCount  <- (map["playlist_count"], IntTransform())
        self.likesCount     <- (map["likes_count"], IntTransform())
        self.followersCount <- (map["followers_count"], IntTransform())
        self.followingCount <- (map["following_count"], IntTransform())
    }
}
