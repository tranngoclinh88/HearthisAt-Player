//
//  Service.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class Service: ControllerProvider {
    
    // MARK: Properties
    
    /// Application configuration.
    let config: AppConfig
    /// Builder for requests.
    let requestBuilder: RequestBuilder
    /// Executor for requests.
    let requestExecutor: RequestExecutor
    
    /// Factory that owns and initializes all controllers.
    private let controllerFactory: ControllerFactory
    
    /// The active artists controller.
    var artistController: ArtistController {
        return controllerFactory.artistController
    }
    /// The active feed controller.
    var feedController: FeedController {
        return controllerFactory.feedController
    }
    /// The active tracks controller.
    var tracksController: TracksController {
        return controllerFactory.tracksController
    }
    /// The active playback controller.
    var playbackController: PlaybackController {
        return controllerFactory.playbackController
    }
    
    // MARK: Init
    
    init(with config: AppConfig,
         requestBuilder: RequestBuilder,
         requestExecutor: RequestExecutor,
         controllerFactoryType: ControllerFactory.Type) {
        self.config = config
        self.requestBuilder = requestBuilder
        self.requestExecutor = requestExecutor
        
        self.controllerFactory = controllerFactoryType.init(with: config,
                                                            requestBuilder: requestBuilder,
                                                            requestExecutor: requestExecutor)
    }
}

extension UIViewController {
 
    /// Application service.
    var service: Service! {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.service
    }
}
