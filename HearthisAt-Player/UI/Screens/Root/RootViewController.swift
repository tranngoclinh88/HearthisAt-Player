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
        
        service.playbackController.notificationService.add(listener: self)
        
        backgroundGradientView.colors = UIColor.hta_backgroundGradient
    }
}

extension RootViewController: PlaybackControllerNotifyable {
    
    func playbackController(_ controller: PlaybackController,
                            didUpdate state: PlayableItem.State,
                            of item: PlayableItem) {
        
        updateBackgroundView(for: state, item: item)
    }
    
    private func updateBackgroundView(for state: PlayableItem.State,
                                      item: PlayableItem) {
        guard let artworkUrl = item.object.playableArtworkUrl else { return }
        
        switch state {
        case .playing, .paused, .loading, .ready:
            backgroundAlbumArtView.imageUrl = artworkUrl
            
        default:
            backgroundAlbumArtView.imageUrl = nil
        }
    }
}
