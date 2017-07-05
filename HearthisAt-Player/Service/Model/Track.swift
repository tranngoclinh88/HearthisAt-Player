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
    
    private(set) var id: String?
    private(set) var createdAt: Date?
    private(set) var releaseDate: Date?
    private(set) var userId: String?
    private(set) var duration: String?
    private(set) var permalink: String?
    private(set) var description: String?
    private(set) var geo: String?
    private(set) var tags: String?
    private(set) var taggedArtists: String?
    private(set) var beatsPerMinute: String?
    private(set) var key: String?
    private(set) var license: String?
    private(set) var version: String?
    private(set) var type: String?
    private(set) var downloadable: String?
    private(set) var genre: String?
    private(set) var genreSlush: String?
    private(set) var title: String?
    private(set) var uri: String?
    private(set) var permalinkUrl: String?
    private(set) var thumbnailUrl: String?
    private(set) var artworkUrl: String?
    private(set) var backgroundUrl: String?
    private(set) var waveformDataUrl: String?
    private(set) var waveformUrl: String?
    private(set) var user: User?
    
    private(set) var streamUrl: String?
    private(set) var downloadUrl: String?
    
    private(set) var playbackCount: String?
    private(set) var downloadCount: String?
    private(set) var favoritingsCount: String?
    private(set) var resharesCount: String?
    private(set) var commentsCount: String?
    
    private(set) var isFavorited: Bool?
    private(set) var isReshared: Bool?
    
    // MARK: Mapping
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.id                 <- map["id"]
        self.createdAt          <- (map["created_at"], DateTransform())
        self.releaseDate        <- (map["release_date"], DateTransform())
        self.userId             <- map["user_id"]
        self.duration           <- map["duration"]
        self.permalink          <- map["permalink"]
        self.description        <- map["description"]
        self.geo                <- map["geo"]
        self.tags               <- map["tags"]
        self.taggedArtists      <- map["taged_artists"]
        self.beatsPerMinute     <- map["bpm"]
        self.key                <- map["key"]
        self.license            <- map["license"]
        self.version            <- map["version"]
        self.type               <- map["type"]
        self.downloadable       <- map["downloadable"]
        self.genre              <- map["genre"]
        self.genreSlush         <- map["genre_slush"]
        self.title              <- map["title"]
        self.uri                <- map["uri"]
        self.permalinkUrl       <- map["permalink_url"]
        self.thumbnailUrl       <- map["thumb"]
        self.artworkUrl         <- map["artwork_url_retina"]
        self.backgroundUrl      <- map["background_url"]
        self.waveformDataUrl    <- map["waveform_data"]
        self.waveformUrl        <- map["waveform_url"]
        self.user               <- map["user"]
        self.streamUrl          <- map["stream_url"]
        self.downloadUrl        <- map["download_url"]
        self.playbackCount      <- map["playback_count"]
        self.downloadCount      <- map["download_count"]
        self.favoritingsCount   <- map["favoritings_count"]
        self.resharesCount      <- map["reshares_count"]
        self.commentsCount      <- map["comment_count"]
        self.isFavorited        <- map["favorited"]
        self.isReshared         <- map["reshared"]
    }
}
