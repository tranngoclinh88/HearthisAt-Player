//
//  MutablePlayableItem.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class MutablePlayableItem: PlayableItem {
    
    private var _currentState: PlayableItem.State = .ready
    override var currentState: PlayableItem.State {
        get {
            return _currentState
        } set {
            _currentState = newValue
            updateListeners({ $0.0.playableItem(self, didUpdate: newValue )})
        }
    }
}
