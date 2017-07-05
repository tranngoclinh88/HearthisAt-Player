//
//  ApiController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class ApiController: Controller {
    
    // MARK: Properties
    
    let config: Config
    let requestBuilder: RequestBuilder
    let requestExecutor: RequestExecutor
    
    // MARK: Init
    
    required init(with config: Config,
                  requestBuilder: RequestBuilder,
                  requestExecutor: RequestExecutor) {
        self.config = config
        self.requestBuilder = requestBuilder
        self.requestExecutor = requestExecutor
    }
}
