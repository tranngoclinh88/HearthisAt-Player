//
//  FeedViewController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class FeedViewController: PagingTableViewController {
 
    // MARK: Defaults
    
    fileprivate struct Defaults {
        static let cellNibName = "FeedItemCell"
        static let cellReuseIdentifier = "FeedItemCell"
    }
    
    // MARK: Properties
    
    var popularFeed: TrackFeed {
        return service.feedController.popularFeed
    }
    private(set) var artistProfileProviders: [Artist.Id : FeedArtistProfileProvider] = [:]
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "screen.feed.title".localized()
        
        // use autosizing
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cell
        let nib = UINib(nibName: Defaults.cellNibName, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Defaults.cellReuseIdentifier)
        
        loadNextPageOfData()
    }
    
    override func loadNextPageOfData(completion: @escaping ((Bool) -> Void)) {
        service.feedController.loadNextPage(of: popularFeed,
                                            success: { (feed, newPage) in
                                                self.tableView.reloadData()
                                                completion(true)
        }) { (error) in
            dump(error)
            completion(false)
            // TODO - Handle error
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularFeed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Defaults.cellReuseIdentifier, for: indexPath) as! FeedItemCell
        let track = popularFeed.allItems[indexPath.row]
        
        cell.index = indexPath.row + 1
        cell.title = track.user?.username
        cell.imageUrl = track.user?.avatarUrl
        
        let profileProvider = self.profileProvider(for: track.user)
        cell.profileProvider = profileProvider
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let track = popularFeed.allItems[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Tracks", bundle: .main)
        let tracksViewController = storyboard.instantiateViewController(withIdentifier: "TracksViewController") as! TracksViewController
        
        tracksViewController.artist = track.user
        
        self.navigationController?.pushViewController(tracksViewController, animated: true)
    }
    
    // MARK: Profile Providers
    
    private func profileProvider(for artist: Artist?) -> FeedArtistProfileProvider? {
        guard let artist = artist, let id = artist.id else { return nil }
        if self.artistProfileProviders[id] == nil {
            self.artistProfileProviders[id] = FeedArtistProfileProvider(for: artist,
                                                                        service: self.service)
        }
        return self.artistProfileProviders[id]
    }
}
