//
//  RootViewController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var backgroundGradientView: GradientView!
    @IBOutlet weak var backgroundAlbumArtView: AlbumArtBackgroundView!
    @IBOutlet weak var miniPlayer: MiniPlayer!
    
    // MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        miniPlayer.delegate = self
        service.playbackController.notificationService.add(listener: self)
        
        backgroundGradientView.colors = UIColor.hta_backgroundGradient
    }
}

extension RootViewController: PlaybackControllerNotifyable {
    
    func playbackController(_ controller: PlaybackController,
                            didUpdate state: PlayableItem.State,
                            of item: PlayableItem) {
        
        updateBackgroundView(for: item, state: state)
        updateMiniPlayer(for: item, state: state)
    }
    
    private func updateBackgroundView(for item: PlayableItem,
                                      state: PlayableItem.State) {
        guard let artworkUrl = item.object.playableArtworkUrl else {
            backgroundAlbumArtView.imageUrl = nil
            return
        }
        
        switch state {
        case .playing, .paused, .loading, .ready:
            backgroundAlbumArtView.imageUrl = artworkUrl
            
        default:
            backgroundAlbumArtView.imageUrl = nil
        }
    }
    
    private func updateMiniPlayer(for item: PlayableItem,
                                  state: PlayableItem.State) {
        miniPlayer.buttonState = miniPlayerButtonState(for: state)
        
        switch state {
        case .ready:
            miniPlayer.title = nil
            miniPlayer.subtitle = nil
            
        case .playing, .paused:
            miniPlayer.title = item.object.playableTitle ?? "general.title.unknown".localized()
            miniPlayer.subtitle = item.object.playableDetails ?? "general.title.unknown".localized()
            
        case .loading:
            miniPlayer.title = item.object.playableTitle ?? "general.title.unknown".localized()
            miniPlayer.subtitle = "general.title.loading".localized()
            
        case .failed:
            miniPlayer.subtitle = "general.title.failed".localized()
        }
        
    }
    
    private func miniPlayerButtonState(for itemState: PlayableItem.State) -> MiniPlayer.ButtonState {
        switch itemState {
        case .failed, .paused, .ready:
            return .play
        default:
            return .pause
        }
    }
}

extension RootViewController: MiniPlayerDelegate {
    
    func miniPlayer(playPauseButtonPressed miniPlayer: MiniPlayer) {
        guard let currentItem = service.playbackController.currentItem else { return }
        
        switch miniPlayer.buttonState {
        case .pause:
            currentItem.pause()
        default:
            currentItem.play()
        }
    }
}
