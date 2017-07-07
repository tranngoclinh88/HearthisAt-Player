//
//  PlayableItem.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Listenable
import Jukebox

protocol Playable {
    
    func contentUrl() -> URL?
}

protocol PlayableItemResponder: class {
    
    func playableItem(requestPlay item: PlayableItem)
    
    func playableItem(requestPause item: PlayableItem)
}

protocol PlayableItemObservable {
    
    func playableItem(_ item: PlayableItem,
                      didUpdate state: PlayableItem.State)
}

class PlayableItem: Listenable<PlayableItemObservable> {
    
    // MARK: Types
    
    enum State {
        case ready
        case playing
        case paused
        case loading
        case failed
    }
    
    // MARK: Properties
    
    let object: Playable
    
    private weak var responder: PlayableItemResponder?
    
    private(set) var currentState: State = .ready
    
    // MARK: Init
    
    init(for object: Playable, responder: PlayableItemResponder) {
        self.object = object
        self.responder = responder
    }
    
    // MARK: Actions
    
    func play() {
        responder?.playableItem(requestPlay: self)
    }
    
    func pause() {
        responder?.playableItem(requestPause: self)
    }
}

extension PlayableItem.State {
    
    static func fromJukeboxState(_ state: Jukebox.State) -> PlayableItem.State {
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
