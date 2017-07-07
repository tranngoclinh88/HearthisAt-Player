//
//  FeedArtistProfileProvider.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

protocol FeedArtistProfileProviderDelegate: class {
    
    func feedArtistProfileProvider(_ provider: FeedArtistProfileProvider,
                                   didUpdate state: FeedArtistProfileProvider.State)
}

class FeedArtistProfileProvider {
    
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
    
    weak var delegate: FeedArtistProfileProviderDelegate?
    
    private(set) var currentState: State = .ready {
        didSet {
            delegate?.feedArtistProfileProvider(self, didUpdate: currentState)
        }
    }
    
    // MARK: Init
    
    init(for artist: Artist, service: Service) {
        self.artist = artist
        self.service = service
        
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
