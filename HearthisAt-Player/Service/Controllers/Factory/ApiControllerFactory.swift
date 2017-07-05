//
//  ApiControllerFactory.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class ApiControllerFactory: ControllerFactory {
    
    private(set) var tracksController: TracksController
    
    // MARK: Init
    
    required init(with config: AppConfig,
                  requestBuilder: RequestBuilder,
                  requestExecutor: RequestExecutor) {
        
        self.tracksController = TracksApiController(with: config,
                                                    requestBuilder: requestBuilder,
                                                    requestExecutor: requestExecutor)
    }
}
