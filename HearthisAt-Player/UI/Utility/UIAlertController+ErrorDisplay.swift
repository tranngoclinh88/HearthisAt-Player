//
//  UIAlertController+ErrorDisplay.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 08/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func errorController(title: String? = nil,
                                message: String,
                                allowCancel: Bool = true,
                                retryHandler:(() -> Void)? = nil) -> UIAlertController {
        
        let title = title ?? "general.error.title".localized()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if allowCancel || retryHandler == nil {
            alertController.addAction(UIAlertAction(title: "general.error.cancel".localized(),
                                                    style: .cancel,
                                                    handler: nil))
        }
        
        if let retryHandler = retryHandler {
            alertController.addAction(UIAlertAction(title: "general.error.retry".localized(),
                                                    style: .default,
                                                    handler: { (_) in
                                                        retryHandler()
            }))
        }
        
        return alertController
    }
}
