//
//  TracksViewController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import TinyConstraints

class TracksViewController: PagingTableViewController {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let cellNibName = "TrackItemCell"
        static let cellReuseIdentifier = "TrackItemCell"
    }
    
    // MARK: Properties
    
    var artist: User!
    weak var profileProvider: ArtistProfileProvider?
    
    @IBOutlet weak private var headerView: TracksHeaderView!
    
    private var tracksList: TracksList? {
        return service.tracksController.tracks(for: self.artist)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileProvider?.add(listener: self)
        if let state = profileProvider?.currentState {
            updateHeaderView(forProfileProviderWith: state)
        }
        headerView.delegate = self
        
        // register cell
        let nib = UINib(nibName: Defaults.cellNibName, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Defaults.cellReuseIdentifier)
        
        if let tracksList = self.tracksList {
            updatePagingAbility(canPage: tracksList.canPageFurther)
        } else {
            loadNextPageOfData()
        }
    }
    
    override func loadNextPageOfData(completion: @escaping ((Bool, Bool) -> Void)) {
        
        let successHandler: (([Track], TracksList) -> Void) = { newTracks, tracksList in
            self.tableView.reloadData()
            completion(true, tracksList.canPageFurther)
        }
        
        let failureHandler: Controller.MethodFailure = { error in
            // TODO - Handle error
            completion(false, false)
        }
        
        if let tracksList = self.tracksList {
            service.tracksController.loadNextPage(of: tracksList,
                                                  success: successHandler,
                                                  failure: failureHandler)
        } else {
            service.tracksController.loadTracks(for: artist,
                                                pageIndex: nil,
                                                count: nil,
                                                success: successHandler,
                                                failure: failureHandler)
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracksList?.allItems.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Defaults.cellReuseIdentifier, for: indexPath) as! TrackItemCell
        
        return cell
    }
    
    // MARK: ArtistProfileProvider
    
    fileprivate func updateHeaderView(forProfileProviderWith state: ArtistProfileProvider.State) {
        switch state {
            
        case .available(let profile):
            headerView.title = profile.username
            headerView.subtitle = generateSubtitle(from: profile)
            headerView.avatarUrl = profile.avatarUrl
            
        case .loading:
            headerView.title = "screen.tracks.header.artistname.placeholder".localized()
            headerView.subtitle = "screen.tracks.header.artistdetails.loading".localized()
            headerView.avatarUrl = nil
            
        case .failed(_):
            headerView.title = "general.error.title".localized()
            headerView.subtitle = "screen.tracks.header.artistdetails.error".localized()
            headerView.avatarUrl = nil

        default:
            headerView.title = ""
            headerView.subtitle = ""
            headerView.avatarUrl = nil

        }
    }
    
    private func generateSubtitle(from profile: UserProfile) -> String? {
        if let description = profile.description, description.characters.count > 0 {
            return description
        } else if let geo = profile.geo, geo.characters.count > 0  {
            return geo
        }
        
        return profile.permalink
    }
}

extension TracksViewController: TracksHeaderViewDelegate {
    
    func tracksHeaderView(backButtonPressed view: TracksHeaderView) {
        navigationController?.popViewController(animated: true)
    }
}

extension TracksViewController: ArtistProfileProviderObservable {
    
    func artistProfileProvider(_ provider: ArtistProfileProvider,
                               didUpdate state: ArtistProfileProvider.State) {
        updateHeaderView(forProfileProviderWith: state)
    }
}
