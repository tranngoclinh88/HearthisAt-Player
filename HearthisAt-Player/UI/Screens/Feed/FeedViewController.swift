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
    
    // MARK: Outlets
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    private let headerView: FeedTitleHeaderView = {
        let headerView = FeedTitleHeaderView()
        headerView.title = "screen.feed.title".localized()
        return headerView
    }()
    
    private var popularFeed: TrackFeed {
        return service.feedController.popularFeed
    }
    private(set) var artistProfileProviders: [Artist.Id : ArtistProfileProvider] = [:]
    
    private var transitioningHandler = FeedTransitioningHandler()
    
    // MARK: Init
    
    deinit {
        unregisterForMiniPlayerInsetting()
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForMiniPlayerInsetting()
        
        navigationController?.delegate = transitioningHandler
        title = "screen.feed.title".localized()
        
        headerView.frame.size = headerView.intrinsicContentSize
        tableView.tableHeaderView = headerView
        
        // use autosizing
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cell
        let nib = UINib(nibName: Defaults.cellNibName, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Defaults.cellReuseIdentifier)
        
        loadNextPageOfData()
    }
    
    override func loadNextPageOfData(completion: @escaping ((Bool, Bool) -> Void)) {
        
        if self.state == .loading {
            activityIndicator.startAnimating()
            tableView.isHidden = true
        }
        
        let loadingFinished: () -> Void = {
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false
        }
        
        service.feedController.loadNextPage(of: popularFeed,
                                            success: { (feed, newPage) in
                                                loadingFinished()
                                                
                                                self.tableView.reloadData()
                                                completion(true, feed.canPageFurther)
        }) { (error) in
            loadingFinished()
            
            completion(false, true)
            
            // show alert
            var alert: UIAlertController!
            switch self.state {
                
            case .loading:
                alert = UIAlertController.errorController(message: "screen.feed.error.loading".localized(),
                                                          allowCancel: false,
                                                          retryHandler: {
                    self.loadNextPageOfData()
                })
                
            default:
                alert = UIAlertController.errorController(message: "screen.feed.error.loading".localized())
            }
                
            self.present(alert, animated: true, completion: nil)
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
        
        let selectedBackground = UIView()
        selectedBackground.backgroundColor = .hta_cellHightlight
        cell.selectedBackgroundView = selectedBackground
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let track = popularFeed.allItems[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Tracks", bundle: .main)
        let tracksViewController = storyboard.instantiateViewController(withIdentifier: "TracksViewController") as! TracksViewController
        
        tracksViewController.artist = track.user
        tracksViewController.profileProvider = profileProvider(for: track.user)
        
        self.navigationController?.pushViewController(tracksViewController, animated: true)
    }
    
    // MARK: Profile Providers
    
    private func profileProvider(for artist: Artist?) -> ArtistProfileProvider? {
        guard let artist = artist, let id = artist.id else { return nil }
        if self.artistProfileProviders[id] == nil {
            self.artistProfileProviders[id] = ArtistProfileProvider(for: artist,
                                                                    service: self.service)
        }
        return self.artistProfileProviders[id]
    }
}
