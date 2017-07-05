//
//  ControllerFactory.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

protocol ControllerFactory: class {
    
    // MARK: Properties
    
    var tracksController: TracksController { get }
    
    // MARK: Init
    
    init(with config: AppConfig,
         requestBuilder: RequestBuilder,
         requestExecutor: RequestExecutor)
}
