//
//  MutablePlayableItem.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class MutablePlayableItem<T : Playable>: PlayableItem<T> {
    
    // MARK: Properties
    
    private(set) var stateManager: PlayableItemStateManager!
    
    // MARK: Init
    
    override init(for object: T, responder: PlayableItemResponder) {
        super.init(for: object, responder: responder)
        self.stateManager = PlayableItemStateManager(with: self)
    }
}

extension MutablePlayableItem: PlayableItemStateManagerHandler {
    
    func stateManager(_ manager: PlayableItemStateManager,
                      didUpdate state: PlayableItemStateManager.State) {
        updateListeners({ $0.0.playableItem(self, didUpdate: state) })
    }
}
