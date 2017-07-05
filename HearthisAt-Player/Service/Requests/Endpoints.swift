//
//  Endpoints.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case feed
}

extension Endpoint {
    
    /// The path of the endpoint.
    var path: String {
        switch self {
            
        case .feed:
            return "/feed/"
        }
    }
}
