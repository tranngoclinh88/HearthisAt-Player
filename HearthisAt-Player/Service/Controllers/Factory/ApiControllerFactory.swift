//
//  ApiControllerFactory.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class ApiControllerFactory: ControllerFactory {
    
    private(set) var artistController: ArtistController
    private(set) var feedController: FeedController
    private(set) var playbackController: PlaybackController
    private(set) var tracksController: TracksController
    
    // MARK: Init
    
    required init(with config: AppConfig,
                  requestBuilder: RequestBuilder,
                  requestExecutor: RequestExecutor) {
        
        self.artistController = ArtistApiController(with: config,
                                                    requestBuilder: requestBuilder,
                                                    requestExecutor: requestExecutor)
        self.feedController = FeedApiController(with: config,
                                                requestBuilder: requestBuilder,
                                                requestExecutor: requestExecutor)
        self.tracksController = TracksApiController(with: config,
                                                    requestBuilder: requestBuilder,
                                                    requestExecutor: requestExecutor)
        self.playbackController = PlaybackApiController(with: config,
                                                        requestBuilder: requestBuilder,
                                                        requestExecutor: requestExecutor)
    }
}
