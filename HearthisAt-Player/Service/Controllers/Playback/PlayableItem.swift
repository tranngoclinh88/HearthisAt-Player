//
//  PlayableItem.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Listenable

protocol Playable {
    
    func contentUrl() -> URL?
}

protocol PlayableItemResponder: class {
    
    func playableItem<T>(requestPlay item: PlayableItem<T>)
    
    func playableItem<T>(requestPause item: PlayableItem<T>)
}

protocol PlayableItemObservable {
    
    func playableItem<T>(_ item: PlayableItem<T>,
                      didUpdate state: PlayableItem<T>.State)
}

class PlayableItem<T : Playable>: Listenable<PlayableItemObservable> {
    
    // MARK: Types
    
    enum State {
        case ready
        case playing
        case paused
    }
    
    // MARK: Properties
    
    let object: T
    
    private weak var responder: PlayableItemResponder?
    
    private(set) var currentState: State = .ready
    
    // MARK: Init
    
    init(for object: T, responder: PlayableItemResponder) {
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
