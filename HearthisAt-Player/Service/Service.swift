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
    
    let config: AppConfig
    let requestBuilder: RequestBuilder
    let requestExecutor: RequestExecutor
    private let controllerFactory: ControllerFactory
    
    var feedController: FeedController {
        return controllerFactory.feedController
    }
    var tracksController: TracksController {
        return controllerFactory.tracksController
    }
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
 
    var service: Service! {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.service
    }
}
