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
    case cancelled
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
        guard let executableRequest = request as? ExecutableRequest else {
            let error = RequestExecutorError.unknown
            failure(request, nil, error)
            request.updateListeners({ $0.0.request(request, didFailWith: error, response: nil) })
            return
        }
        let request = executableRequest
        
        request.inProgress = true
        request.updateListeners({ $0.0.request(didBegin: request) })
        
        let dataRequest = Alamofire.request(request.url,
                                            method: request.method,
                                            parameters: request.parameters,
                                            encoding: request.encoding ?? URLEncoding.default,
                                            headers: request.headers)
        request.dataRequest = dataRequest
        
        // handle response
        dataRequest.response { (response) in
            
            // handle cancellation
            guard self.wasCancelled(error: response.error) == false else {
                failure(request, nil, RequestExecutorError.cancelled)
                return
            }
            
            guard let urlResponse = response.response else {
                failure(request, nil, RequestExecutorError.unknown)
                return
            }
            
            let response = Response(rawResponse: urlResponse,
                                    statusCode: urlResponse.statusCode,
                                    data: response.data,
                                    error: response.error)
            request.response = response
            request.inProgress = false
            
            // Handle failed request
            guard response.isSuccessful else {
                let error = response.error ?? RequestExecutorError.unknown
                failure(request, response, error)
                request.updateListeners({ $0.0.request(request, didFailWith: error, response: response) })
                return
            }
            
            success(request, response, response.data)
            request.updateListeners({ $0.0.request(request, didFinishWith: response, data: response.data) })
        }
    }
    
    // MARK: Utility
    
    func wasCancelled(error: Error?) -> Bool {
        guard let error = error else {
            return false
        }
        let nsError = error as NSError
        return nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorCancelled
    }
}
