//
//  Component.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

protocol Component {
    
    /// Construct the component in a designated content view.
    ///
    /// - Parameter view: The designated content view.
    func construct(in view: UIView)
}

@IBDesignable class ViewComponent: UIView, Component {
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.construct(in: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.construct(in: self)
    }
    
    // MARK: Component
    
    open func construct(in view: UIView) {
        
    }
}

@IBDesignable class ImageViewComponent: UIImageView, Component {
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.construct(in: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.construct(in: self)
    }
    
    // MARK: Component
    
    open func construct(in view: UIView) {
        
    }
}
