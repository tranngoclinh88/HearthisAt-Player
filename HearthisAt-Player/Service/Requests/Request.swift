//
//  Request.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    
    // MARK: Properties
    
    let url: URL
    let method: Alamofire.HTTPMethod
    let headers: Alamofire.HTTPHeaders?
    let parameters: Alamofire.Parameters?
    let encoding: Alamofire.ParameterEncoding?
    
    // MARK: Init
    
    init(with url: URL,
         method: Alamofire.HTTPMethod,
         headers: Alamofire.HTTPHeaders?,
         parameters: Alamofire.Parameters?,
         encoding: Alamofire.ParameterEncoding?) {
        self.url = url
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
}
