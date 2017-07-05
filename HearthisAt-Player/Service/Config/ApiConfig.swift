//
//  ApiConfig.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

struct ApiConfig: Config {
    
    // MARK: Keys
    
    private struct Keys {
        static let baseUrl = "baseUrl"
    }
    
    // MARK: Properties
    
    let baseUrl: URL
    
    // MARK: Init
    
    init(with dataDictionary: [String : Any]) {
        
        self.baseUrl = URL(string: dataDictionary[Keys.baseUrl] as! String)!
    }
}
