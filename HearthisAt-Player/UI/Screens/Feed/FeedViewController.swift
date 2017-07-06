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
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // use autosizing
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // register cell
        let nib = UINib(nibName: Defaults.cellNibName, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Defaults.cellReuseIdentifier)
    }
}

extension FeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Defaults.cellReuseIdentifier, for: indexPath) as! FeedItemCell
        
        cell.index = indexPath.row + 1
        
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    
}
