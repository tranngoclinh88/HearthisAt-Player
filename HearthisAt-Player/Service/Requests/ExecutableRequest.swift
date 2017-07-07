//
//  ExecutableRequest.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

protocol ExecutableRequestDelegate: class {
    
    func request(doesRequireCancellation request: Request)
}

class ExecutableRequest: Request {
    
    // MARK: Properties
    
    weak var delegate: ExecutableRequestDelegate?
    
    private var _response: Response?
    override var response: Response? {
        set {
            _response = newValue
        } get {
            return _response
        }
    }
    
    private var _inProgress: Bool = false
    override var inProgress: Bool {
        set {
            _inProgress = inProgress
            if inProgress == false {
                self.delegate = nil
            }
        } get {
            return _inProgress
        }
    }
    
    // MARK: Actions
    
    override func cancel() {
        delegate?.request(doesRequireCancellation: self)
    }
}
