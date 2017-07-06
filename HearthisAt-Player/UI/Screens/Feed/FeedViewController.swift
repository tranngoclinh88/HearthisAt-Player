//
//  FeedViewController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
 
    // MARK: Defaults
    
    fileprivate struct Defaults {
        static let cellNibName = "FeedItemCell"
        static let cellReuseIdentifier = "FeedItemCell"
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var popularFeed: TrackFeed {
        return service.feedController.popularFeed
    }
    fileprivate var isLoadingFeed: Bool = false
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // use autosizing
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cell
        let nib = UINib(nibName: Defaults.cellNibName, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Defaults.cellReuseIdentifier)
        
        // Add paging footer
        let footerView = PagingFooterView()
        footerView.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: footerView.intrinsicContentSize.height)
        tableView.tableFooterView = footerView
        
        loadNextPageOfFeed()
    }
}

extension FeedViewController {
    
    func loadNextPageOfFeed() {
        isLoadingFeed = true
        service.feedController.loadNextPage(of: popularFeed,
                                            success: { (feed, newPage) in
                                                self.isLoadingFeed = false
                                                self.tableView.reloadData()
        }) { (error) in
            self.isLoadingFeed = false
            dump(error)
            // TODO - Handle error
        }
    }
}

extension FeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Defaults.cellReuseIdentifier, for: indexPath) as! FeedItemCell
        let track = popularFeed.allItems[indexPath.row]
        
        cell.index = indexPath.row + 1
        cell.title = track.user?.username
        
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        if !decelerate {
            checkIfPageLoadRequired()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        checkIfPageLoadRequired()
    }
    
    func checkIfPageLoadRequired() {
        let bottomEdge = tableView.contentOffset.y + tableView.frame.size.height
        if bottomEdge >= tableView.contentSize.height {
            guard !self.isLoadingFeed else { return }
            
            loadNextPageOfFeed()
        }
    }
}
