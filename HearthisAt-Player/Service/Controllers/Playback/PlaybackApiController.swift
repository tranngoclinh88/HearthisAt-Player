//
//  PlaybackApiController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Jukebox
import Listenable

class PlaybackApiController: ApiController, PlaybackController {
    
    // MARK: Properties
    
    fileprivate private(set) var jukebox: Jukebox!
    
    fileprivate var currentItem: MutablePlayableItem?
    
    let notificationService = Listenable<PlaybackControllerNotifyable>()
    
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
    
    func generatePlayableItem(for object: Playable) -> PlayableItem {
        return MutablePlayableItem(for: object, responder: self)
    }
}

extension PlaybackApiController: PlayableItemResponder {
 
    func playableItem(requestPlay item: PlayableItem) {
        playItem(item: item, success: nil, failure: nil)
    }
    
    func playableItem(requestPause item: PlayableItem) {
        pauseCurrentItem()
    }
}

extension PlaybackApiController: JukeboxDelegate {
    
    fileprivate func playItem(item: PlayableItem,
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
        
        self.currentItem = item
        jukebox.append(item: JukeboxItem(URL: url), loadingAssets: true)
        jukebox.play()
    }
    
    fileprivate func pauseCurrentItem() {
        jukebox.pause()
    }
    
    // MARK: JukeboxDelegate
    
    func jukeboxStateDidChange(_ jukebox: Jukebox) {
        guard let currentItem = self.currentItem else { return }
        
        let state = PlayableItem.State.fromJukeboxState(jukebox.state)
        currentItem.currentState = state
        notificationService.updateListeners({ $0.0.playbackController(self, didUpdate: state, of: currentItem) })
    }
    
    func jukeboxPlaybackProgressDidChange(_ jukebox: Jukebox) {
        
    }
    
    func jukeboxDidLoadItem(_ jukebox: Jukebox, item: JukeboxItem) {
        
    }
    
    func jukeboxDidUpdateMetadata(_ jukebox: Jukebox, forItem: JukeboxItem) {
        
    }
}
