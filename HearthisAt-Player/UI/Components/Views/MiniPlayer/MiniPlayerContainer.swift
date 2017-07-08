//
//  MiniPlayerContainer.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 08/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import TinyConstraints

class MiniPlayerContainer: ViewComponent {
    
    // MARK: Types
    
    enum VisibilityState {
        case hidden
        case visible
    }
    
    // MARK: Properties
    
    let miniPlayer: MiniPlayer = {
        let miniPlayer = MiniPlayer()
        miniPlayer.translatesAutoresizingMaskIntoConstraints = false
        return miniPlayer
    }()
    private var playerBottomConstraint: NSLayoutConstraint?
    
    private(set) var playerVisibilityState: VisibilityState?
    
    // MARK: Lifecycle
    
    override func construct(in view: UIView) {
        super.construct(in: view)
        
        view.addSubview(miniPlayer)
        miniPlayer.leading(to: view)
        self.playerBottomConstraint = miniPlayer.bottom(to: view)
        miniPlayer.trailing(to: view)
        
        hidePlayer(animated: false, completion: nil)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if miniPlayer.frame.contains(point) {
            return hitView
        }
        return nil
    }
    
    // MARK: Player Visibility
    
    func showPlayer(animated: Bool, completion: ((Bool) -> Void)?) {
        guard self.playerVisibilityState != .visible else {
            completion?(false)
            return
        }
        
        let duration = animated ? 0.3 : 0.0

        if animated {
            let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
            shadowAnimation.fromValue = miniPlayer.layer.shadowOpacity
            shadowAnimation.toValue = 0.3
            shadowAnimation.duration = duration
            shadowAnimation.fillMode = kCAFillModeBoth
            shadowAnimation.isRemovedOnCompletion = false
            miniPlayer.layer.add(shadowAnimation, forKey: nil)
            
        } else {
            miniPlayer.layer.shadowOpacity = 0.3
        }
        
        playerBottomConstraint?.constant = 0.0
        UIView.animate(withDuration: duration,
                       animations:
            {
                self.layoutIfNeeded()
        }) { (finished) in
            completion?(finished)
        }
    }
    
    func hidePlayer(animated: Bool, completion: ((Bool) -> Void)?) {
        guard self.playerVisibilityState != .hidden else {
            completion?(false)
            return
        }
        
        let duration = animated ? 0.3 : 0.0
        
        if animated {
            let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
            shadowAnimation.fromValue = miniPlayer.layer.shadowOpacity
            shadowAnimation.toValue = 0.0
            shadowAnimation.duration = duration
            shadowAnimation.fillMode = kCAFillModeBoth
            shadowAnimation.isRemovedOnCompletion = false
            miniPlayer.layer.add(shadowAnimation, forKey: nil)
            
        } else {
            miniPlayer.layer.shadowOpacity = 0.0
        }
        
        playerBottomConstraint?.constant = miniPlayer.intrinsicContentSize.height
        UIView.animate(withDuration: duration,
                       animations:
            {
                self.layoutIfNeeded()
        }) { (finished) in
            completion?(finished)
        }
        
        
    }
}
