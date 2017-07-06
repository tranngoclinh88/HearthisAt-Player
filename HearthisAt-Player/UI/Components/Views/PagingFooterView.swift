//
//  PagingFooterView.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import TinyConstraints

class PagingFooterView: ViewComponent {
    
    // MARK: Properties
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: 50.0)
    }
    
    // MARK: Lifecycle
    
    override func construct(in view: UIView) {
        super.construct(in: view)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center(in: view)
    }
    
    // MARK: Animation
    
    func startAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }
}
