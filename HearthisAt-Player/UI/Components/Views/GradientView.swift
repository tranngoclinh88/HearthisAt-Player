//
//  GradientView.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

@IBDesignable class GradientView: ViewComponent {
    
    enum Direction {
        case topToBottom
        case leftToRight
        case rightToLeft
        case bottomToTop
    }
    
    // MARK: Properties
    
    var gradientLayer: CAGradientLayer? {
        get {
            if let gradientLayer = self.layer as? CAGradientLayer {
                return gradientLayer
            }
            return nil
        }
    }
    
    var colors: [UIColor]? = nil {
        didSet {
            updateGradient()
        }
    }
    
    var locations: [Double]? = nil {
        didSet {
            updateGradient()
        }
    }
    
    var direction: Direction = .topToBottom {
        didSet {
            updateGradient()
        }
    }
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateGradient()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.colors = [UIColor.black, UIColor.white]
        updateGradient()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        updateGradient()
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    func setColors(_ colors: [UIColor], animated: Bool, duration: Double = 0.3) {
        let fromColors = self.colors
        self.colors = colors
        if animated {
            let animation = CABasicAnimation(keyPath: "colors")
            animation.fromValue = fromColors
            animation.toValue = colors
            animation.duration = duration
            animation.isRemovedOnCompletion = true
            animation.fillMode = kCAFillModeForwards
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            gradientLayer?.add(animation, forKey: "colors")
        }
    }
    
    // MARK: Gradient
    
    func updateGradient() {
        guard let colors = self.colors else {
            gradientLayer?.colors = []
            return
        }
        
        var colorRefs = [CGColor]()
        for color in colors {
            colorRefs.append(color.cgColor)
        }
        gradientLayer?.colors = colorRefs
        
        if let locations = self.locations {
            var locationNumbers = [NSNumber]()
            for location in locations {
                locationNumbers.append(NSNumber(value: location))
            }
            gradientLayer?.locations = locationNumbers
        }
        
        switch direction {
        case .topToBottom:
            gradientLayer?.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer?.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .leftToRight:
            gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer?.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            gradientLayer?.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer?.endPoint = CGPoint(x: 0.0, y: 0.5)
            
        case .bottomToTop:
            gradientLayer?.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer?.endPoint = CGPoint(x: 0.5, y: 0.0)
        }
    }

}
