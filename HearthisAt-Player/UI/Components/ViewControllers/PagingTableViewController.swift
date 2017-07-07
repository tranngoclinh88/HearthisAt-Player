//
//  PagingTableViewController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class PagingTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties

    private var footerView = PagingFooterView()
    
    private var isLoadingData: Bool = false
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add paging footer
        footerView.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: footerView.intrinsicContentSize.height)
        tableView.tableFooterView = footerView
    }
    
    // MARK: Data
    
    func loadNextPageOfData() {
        attemptLoadNextPageOfData()
    }
    
    private func attemptLoadNextPageOfData() {
        guard !isLoadingData else { return }
        
        isLoadingData = true
        loadNextPageOfData { (success) in
            self.isLoadingData = false
        }
    }
    
    func loadNextPageOfData(completion: @escaping ((_ success: Bool) -> Void)) {
        
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
        return cell!
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        let totalNumberOfRows = self.tableView(tableView, numberOfRowsInSection: indexPath.section)
        if indexPath.row >= totalNumberOfRows - 2 {
            footerView.startAnimating()
        } else {
            footerView.stopAnimating()
        }
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        if !decelerate {
            checkIfPagingLoadRequired()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        checkIfPagingLoadRequired()
    }
    
    /// Checks if table view has reached bottom for page load.
    private func checkIfPagingLoadRequired() {
        let bottomEdge = tableView.contentOffset.y + tableView.frame.size.height
        if bottomEdge >= tableView.contentSize.height {
            
            attemptLoadNextPageOfData()
        }
    }
}
