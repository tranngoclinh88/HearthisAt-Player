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
    
    // MARK: Outlets
    
    @IBOutlet weak private var headerView: TracksHeaderView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    var artist: User!
    weak var profileProvider: ArtistProfileProvider?
    
    private var tracksList: TracksList? {
        return service.tracksController.tracks(for: self.artist)
    }
    
    private var dateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        return formatter
    }()
    
    // MARK: Init
    
    deinit {
        unregisterForMiniPlayerInsetting()
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForMiniPlayerInsetting()
        
        // configure header view
        profileProvider?.add(listener: self)
        if let state = profileProvider?.currentState {
            updateHeaderView(forProfileProviderWith: state)
        }
        headerView.delegate = self
        
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
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
        
        let loadingFinished: () -> Void = {
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false
        }
        
        let successHandler: (([Track], TracksList) -> Void) = { newTracks, tracksList in
            loadingFinished()
            
            self.tableView.reloadData()
            completion(true, tracksList.canPageFurther)
        }
        
        let failureHandler: Controller.MethodFailure = { error in
            loadingFinished()
            
            completion(false, false)
            
            // show alert
            let alert = UIAlertController.errorController(message: "screen.tracks.error.loading".localized())
            self.present(alert, animated: true, completion: nil)
        }
        
        if self.state == .loading {
            activityIndicator.startAnimating()
            tableView.isHidden = true
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
        if let track = self.tracksList?.allItems[indexPath.row] {
         
            cell.title = track.title
            cell.duration = dateComponentsFormatter.string(from: track.duration ?? 0.0)
        }
        
        let selectedBackground = UIView()
        selectedBackground.backgroundColor = .hta_cellHightlight
        cell.selectedBackgroundView = selectedBackground
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let track = tracksList?.allItems[indexPath.row] else { return }
        
        let playableItem = service.playbackController.generatePlayableItem(for: track)
        playableItem.play()
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
