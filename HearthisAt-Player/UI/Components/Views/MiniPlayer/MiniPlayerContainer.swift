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
    
    struct Notifications {
        static let didUpdateVisibilityState = NSNotification.Name(rawValue: "miniPlayerDidUpdateVisibilityState")
        
        struct UserInfoKeys {
            static let height = "height"
            static let state = "state"
        }
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
        self.playerVisibilityState = .visible
        
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
            
            NotificationCenter.default.post(name: Notifications.didUpdateVisibilityState,
                                            object: nil,
                                            userInfo: [Notifications.UserInfoKeys.height: self.miniPlayer.intrinsicContentSize.height,
                                                       Notifications.UserInfoKeys.state: self.playerVisibilityState!])
            
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
            self.playerVisibilityState = .hidden
            
            NotificationCenter.default.post(name: Notifications.didUpdateVisibilityState,
                                            object: nil,
                                            userInfo: [Notifications.UserInfoKeys.height: self.miniPlayer.intrinsicContentSize.height,
                                                       Notifications.UserInfoKeys.state: self.playerVisibilityState!])

            
            completion?(finished)
        }
        
        
    }
}

extension UIViewController {
    
    func registerForMiniPlayerInsetting() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(miniPlayerDidUpdateVisibilityState(_:)),
                                               name: MiniPlayerContainer.Notifications.didUpdateVisibilityState,
                                               object: nil)
        
        if let rootViewController = UIApplication.shared.delegate?.window??.rootViewController as? RootViewController {
            let height = rootViewController.miniPlayer.intrinsicContentSize.height
            let state = rootViewController.miniPlayerContainer.playerVisibilityState ?? .hidden
            insetChildScrollViews(forMiniPlayer: height, state: state)
        }
    }
    
    func unregisterForMiniPlayerInsetting() {
        NotificationCenter.default.removeObserver(MiniPlayerContainer.Notifications.didUpdateVisibilityState)
    }
    
    // MARK: Notifications
    
    func miniPlayerDidUpdateVisibilityState(_ notification: Notification) {
        let height = notification.userInfo![MiniPlayerContainer.Notifications.UserInfoKeys.height] as! CGFloat
        let state = notification.userInfo![MiniPlayerContainer.Notifications.UserInfoKeys.state] as! MiniPlayerContainer.VisibilityState
        
        insetChildScrollViews(forMiniPlayer: height, state: state)
    }
    
    // MARK: Insetting
    
    private func insetChildScrollViews(forMiniPlayer height: CGFloat, state: MiniPlayerContainer.VisibilityState) {
        for scrollView in view.subviews.flatMap({ $0 as? UIScrollView }) {
            switch state {
            case .hidden:
                if scrollView.contentInset.bottom > height {
                    scrollView.contentInset.bottom -= height
                }
                
            case .visible:
                if scrollView.contentInset.bottom < height {
                    scrollView.contentInset.bottom += height
                }
            }
            
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        }
    }
}
