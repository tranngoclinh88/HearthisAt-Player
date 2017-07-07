//
//  PlaybackApiController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Jukebox

class PlaybackApiController: ApiController, PlaybackController {
    
    // MARK: Properties
    
    fileprivate private(set) var jukebox: Jukebox!
    
    fileprivate weak var currentItemState: PlayableItemStateManager?
    
    // MARK: Init
    
    required init(with config: Config,
                  requestBuilder: RequestBuilder,
                  requestExecutor: RequestExecutor) {
        super.init(with: config,
                   requestBuilder: requestBuilder,
                   requestExecutor: requestExecutor)
        
        self.jukebox = Jukebox(delegate: self, items: [])
    }
    
    // MARK: Methods
    
    func generatePlayableItem<T>(for object: T) -> PlayableItem<T> {
        return MutablePlayableItem<T>(for: object, responder: self)
    }
}

extension PlaybackApiController: PlayableItemResponder {
 
    func playableItem<T>(requestPlay item: PlayableItem<T>) {
        playItem(item: item, success: nil, failure: nil)
    }
    
    func playableItem<T>(requestPause item: PlayableItem<T>) {
        pauseCurrentItem()
    }
}

extension PlaybackApiController: JukeboxDelegate {
    
    fileprivate func playItem<T>(item: PlayableItem<T>,
                  success: (() -> Void)?,
                  failure: ((Error) -> Void)?) {
        guard let item = item as? MutablePlayableItem,
            let url = item.object.contentUrl() else {
            failure?(PlaybackError.missingContentUrl)
            return
        }
        
        if let currentItem = jukebox.currentItem {
            jukebox.stop()
            jukebox.remove(item: currentItem)
        }
        
        self.currentItemState = item.stateManager
        jukebox.append(item: JukeboxItem(URL: url), loadingAssets: true)
        jukebox.play()
    }
    
    fileprivate func pauseCurrentItem() {
        jukebox.pause()
    }
    
    // MARK: JukeboxDelegate
    
    func jukeboxStateDidChange(_ jukebox: Jukebox) {
        let state = PlayableItemStateManager.State.fromJukeboxState(jukebox.state)
        currentItemState?.updateState(to: state)
    }
    
    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
        
    }
    
    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem) {
        
    }
    
    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
        
    }
}
