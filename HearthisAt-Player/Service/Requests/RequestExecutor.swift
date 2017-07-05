//
//  RequestExecutor.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Alamofire

enum RequestExecutorError: Error {
    case unknown
}

class RequestExecutor {
 
    // MARK: Types
    
    typealias ExecutionSuccess = (_ request: Request, _ response: Response, _ data: Data?) -> Void
    typealias ExecutionFailure = (_ request: Request, _ response: Response?, _ error: Error) -> Void
    
    // MARK: Execution
    
    /// Execute a request.
    ///
    /// - Parameters:
    ///   - request: The request to execute.
    ///   - success: Execution on a successful request.
    ///   - failure: Execution on a failed request.
    func execute(_ request: Request,
                 success: @escaping ExecutionSuccess,
                 failure: @escaping ExecutionFailure) {
        
        let dataRequest = Alamofire.request(request.url,
                                            method: request.method,
                                            parameters: request.parameters,
                                            encoding: request.encoding ?? URLEncoding.default,
                                            headers: request.headers)
        dataRequest.response { (response) in
            guard let urlResponse = response.response else {
                failure(request, nil, RequestExecutorError.unknown)
                return
            }
            
            let response = Response(for: request,
                                    rawResponse: urlResponse,
                                    statusCode: urlResponse.statusCode,
                                    data: response.data,
                                    error: response.error)

            // Handle failed request
            guard response.isSuccessful else {
                failure(request, response, response.error ?? RequestExecutorError.unknown)
                return
            }
            
            success(request, response, response.data)
        }
    }
}
