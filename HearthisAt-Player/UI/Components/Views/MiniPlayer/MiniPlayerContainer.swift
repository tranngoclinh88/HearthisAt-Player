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
    
    // MARK: Properties
    
    let miniPlayer: MiniPlayer = {
        let miniPlayer = MiniPlayer()
        miniPlayer.translatesAutoresizingMaskIntoConstraints = false
        return miniPlayer
    }()
    
    // MARK: Lifecycle
    
    override func construct(in view: UIView) {
        super.construct(in: view)
        
        view.addSubview(miniPlayer)
        miniPlayer.leading(to: view)
        miniPlayer.bottom(to: view)
        miniPlayer.trailing(to: view)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if miniPlayer.frame.contains(point) {
            return hitView
        }
        return nil
    }
}
