//
//  User.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import ObjectMapper

typealias Artist = User

struct User: Mappable {

    typealias Id = Int
    
    private(set) var id: Id?
    private(set) var permalink: String?
    private(set) var username: String?
    private(set) var uri: String?
    private(set) var permalinkUrl: URL?
    private(set) var avatarUrl: URL?
    
    // MARK: Mappable
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.id             <- (map["id"], IntTransform())
        self.permalink      <- map["permalink"]
        self.username       <- map["username"]
        self.uri            <- map["uri"]
        self.permalinkUrl   <- (map["permalink_url"], URLTransform())
        self.avatarUrl      <- (map["avatar_url"], URLTransform())
    }
}
