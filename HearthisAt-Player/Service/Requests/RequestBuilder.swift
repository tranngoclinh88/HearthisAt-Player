//
//  RequestBuilder.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

class RequestBuilder {
    
    // MARK: Properties
    
    private let config: AppConfig
    
    // MARK: Init
    
    init(with config: AppConfig) {
        self.config = config
    }
    
    // MARK: Building
    
    /// Build a new request.
    ///
    /// - Parameters:
    ///   - endpoint: The endpoint to request from.
    ///   - method: The method to use.
    ///   - headers: The headers to send.
    ///   - parameters: The parameters to send.
    ///   - encoding: The type of encoding to use.
    /// - Returns: A request to send.
    func build(for endpoint: Endpoint,
               method: Alamofire.HTTPMethod,
               headers: Alamofire.HTTPHeaders? = nil,
               parameters: Alamofire.Parameters? = nil,
               encoding: Alamofire.ParameterEncoding? = nil) -> Request? {
        
        // attempt to build Url
        let urlString = "\(config.api.baseUrl)\(endpoint.path)"
        guard let url = URL(string: urlString) else { return nil }
        
        return Request(with: url,
                       method: method,
                       headers: headers,
                       parameters: parameters,
                       encoding: encoding)
    }
}
