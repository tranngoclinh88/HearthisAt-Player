//
//  AppConfig.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

struct AppConfig: Config {
    
    private struct Keys {
        static let apiConfig = "APIConfig"
    }
    
    // MARK: Properties
    
    let api: ApiConfig
    
    // MARK: Init
    
    init(with dataDictionary: [String : Any]) {
        
        self.api = ApiConfig(with: dataDictionary[Keys.apiConfig] as! [String : Any])
    }
}
