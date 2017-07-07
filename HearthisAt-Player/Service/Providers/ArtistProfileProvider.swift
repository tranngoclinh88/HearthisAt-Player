//
//  FeedArtistProfileProvider.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation
import Listenable

protocol ArtistProfileProviderObservable: class {
    
    func artistProfileProvider(_ provider: ArtistProfileProvider,
                               didUpdate state: ArtistProfileProvider.State)
}

class ArtistProfileProvider: Listenable<ArtistProfileProviderObservable> {
    
    // MARK: Types
    
    enum State {
        case ready
        case loading
        case available(profile: ArtistProfile)
        case failed(error: Error)
    }
    
    // MARK: Properties
    
    let artist: Artist
    let service: Service
    
    private(set) var currentState: State = .ready {
        didSet {
            updateListeners({ $0.0.artistProfileProvider(self, didUpdate: currentState) })
        }
    }
    
    // MARK: Init
    
    init(for artist: Artist, service: Service) {
        self.artist = artist
        self.service = service
        super.init()
        
        reloadData()
    }
    
    func reloadData(forceLoad: Bool = false) {
        if let profile = service.artistController.profile(for: artist), forceLoad == false {
            self.currentState = .available(profile: profile)
        } else { // perform load
            currentState = .loading
            service.artistController.loadProfile(for: artist,
                                                 success:
                { (profile) in
                    self.currentState = .available(profile: profile)
            }) { (error) in
                switch self.currentState {
                    
                case .available(_):() // do nothing if already available
                    
                default:
                    self.currentState = .failed(error: error)
                }
            }
        }
    }
}
