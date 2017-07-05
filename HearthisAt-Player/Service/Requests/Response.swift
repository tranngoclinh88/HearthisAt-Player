//
//  Response.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class Response {
 
    /// The raw response.
    let raw: URLResponse
    /// The corresponding request.
    let request: Request
    /// The status code of the response.
    let statusCode: Int
    /// The data included with the response.
    let data: Data?
    /// The error included with the response.
    let error: Error?
    
    /// Whether the response is a successful one.
    var isSuccessful: Bool {
        return error == nil && 200 ... 299 ~= statusCode 
    }
    
    init(for request: Request,
         rawResponse: URLResponse,
         statusCode: Int,
         data: Data?,
         error: Error?) {
        self.request = request
        self.raw = rawResponse
        self.statusCode = statusCode
        self.data = data
        self.error = error
    }
}
