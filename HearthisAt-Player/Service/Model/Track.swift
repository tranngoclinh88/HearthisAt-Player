//
//  Track.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import ObjectMapper

struct Track: Mappable {
    
    var id: Int?
    var createdAt: Date?
    var releaseDate: Date?
    var userId: Int?
    var duration: Int?
    var permalink: String?
    
    // MARK: Mapping
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.id             <- map["id"]
        self.createdAt      <- map["created_at"]
        self.releaseDate    <- map["release_date"]
        self.userId         <- map["user_id"]
        self.duration       <- map["duration"]
        self.permalink      <- map["permalink"]
    }
}
