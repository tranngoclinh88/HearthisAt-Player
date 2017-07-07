//
//  PlayableItemStateManager.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Jukebox

protocol PlayableItemStateManagerHandler: class {
    
    func stateManager(_ manager: PlayableItemStateManager,
                      didUpdate state: PlayableItemStateManager.State)
}

class PlayableItemStateManager {
    
    // MARK: Types
    
    enum State {
        case ready
        case playing
        case paused
        case loading
        case failed
    }
    
    // MARK: Properties
    
    private(set) var currentState: State = .ready
    
    weak private var handler: PlayableItemStateManagerHandler?
    
    init(with handler: PlayableItemStateManagerHandler) {
        self.handler = handler
    }
    
    // MARK: Actions
    
    func updateState(to newState: State) {
        handler?.stateManager(self, didUpdate: newState)
    }
}

extension PlayableItemStateManager.State {
    
    static func fromJukeboxState(_ state: Jukebox.State) -> PlayableItemStateManager.State {
        switch state {
        case .failed:
            return .failed
        case .loading:
            return .loading
        case .paused:
            return .paused
        case .playing:
            return .playing
        case .ready:
            return .ready
        }
    }
}
