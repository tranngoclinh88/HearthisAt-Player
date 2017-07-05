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
    
    private(set) var id: Int?
    private(set) var userId: Int?

    private(set) var title: String?
    private(set) var description: String?
    private(set) var createdAt: Date?
    private(set) var releaseDate: Date?
    private(set) var genre: String?

    private(set) var duration: Int?
    
    private(set) var permalink: String?
    private(set) var geo: String?
    private(set) var tags: String?
    private(set) var taggedArtists: String?
    private(set) var beatsPerMinute: Int?
    private(set) var key: String?
    private(set) var license: String?
    private(set) var version: String?
    private(set) var type: String?
    private(set) var isDownloadable: Bool?
    private(set) var genreSlush: String?
    private(set) var uri: String?
    private(set) var permalinkUrl: URL?
    
    private(set) var thumbnailUrl: URL?
    private(set) var artworkUrl: URL?
    private(set) var backgroundUrl: URL?
    
    private(set) var waveformDataUrl: URL?
    private(set) var waveformUrl: URL?
    
    private(set) var user: User?
    
    private(set) var streamUrl: URL?
    private(set) var downloadUrl: URL?
    
    private(set) var playbackCount: Int?
    private(set) var downloadCount: Int?
    private(set) var favoritingsCount: Int?
    private(set) var resharesCount: Int?
    private(set) var commentsCount: Int?
    
    private(set) var isFavorited: Bool?
    private(set) var isReshared: Bool?
    
    // MARK: Mapping
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        self.id                 <- (map["id"], IntTransform())
        self.createdAt          <- (map["created_at"], DateTransform())
        self.releaseDate        <- (map["release_date"], DateTransform())
        self.userId             <- (map["user_id"], IntTransform())
        self.duration           <- (map["duration"], IntTransform())
        self.permalink          <- map["permalink"]
        self.description        <- map["description"]
        self.geo                <- map["geo"]
        self.tags               <- map["tags"]
        self.taggedArtists      <- map["taged_artists"]
        self.beatsPerMinute     <- (map["bpm"], IntTransform())
        self.key                <- map["key"]
        self.license            <- map["license"]
        self.version            <- map["version"]
        self.type               <- map["type"]
        self.isDownloadable     <- (map["downloadable"], BoolTransform())
        self.genre              <- map["genre"]
        self.genreSlush         <- map["genre_slush"]
        self.title              <- map["title"]
        self.uri                <- map["uri"]
        self.permalinkUrl       <- (map["permalink_url"], URLTransform())
        self.thumbnailUrl       <- (map["thumb"], URLTransform())
        self.artworkUrl         <- (map["artwork_url_retina"], URLTransform())
        self.backgroundUrl      <- (map["background_url"], URLTransform())
        self.waveformDataUrl    <- (map["waveform_data"], URLTransform())
        self.waveformUrl        <- (map["waveform_url"], URLTransform())
        self.user               <- map["user"]
        self.streamUrl          <- (map["stream_url"], URLTransform())
        self.downloadUrl        <- (map["download_url"], URLTransform())
        self.playbackCount      <- (map["playback_count"], IntTransform())
        self.downloadCount      <- (map["download_count"], IntTransform())
        self.favoritingsCount   <- (map["favoritings_count"], IntTransform())
        self.resharesCount      <- (map["reshares_count"], IntTransform())
        self.commentsCount      <- (map["comment_count"], IntTransform())
        self.isFavorited        <- map["favorited"]
        self.isReshared         <- map["reshared"]
    }
}
