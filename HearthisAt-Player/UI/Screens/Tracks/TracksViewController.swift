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
    
    @IBOutlet weak private var headerView: TracksHeaderView!
    
    private var tracksList: TracksList? {
        return service.tracksController.tracks(for: self.artist)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register cell
        let nib = UINib(nibName: Defaults.cellNibName, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Defaults.cellReuseIdentifier)
        
        if self.tracksList == nil {
            performInitialDataLoad()
        }
    }
    
    override func loadNextPageOfData(completion: @escaping ((Bool) -> Void)) {
        
        let successHandler: (([Track], TracksList) -> Void) = { newTracks, tracksList in
            self.tableView.reloadData()
            completion(true)
        }
        
        let failureHandler: Controller.MethodFailure = { error in
            // TODO - Handle error
            completion(false)
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
}
