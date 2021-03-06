//
//  Config.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

/// An object that contains configuration data for the application.
protocol Config {
    
    init(with dataDictionary: [String : Any])
}
