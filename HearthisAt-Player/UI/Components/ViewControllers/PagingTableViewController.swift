//
//  PagingTableViewController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class PagingTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Types
    
    enum State {
        case normal
        case loading
        case paging
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties

    private var footerView = PagingFooterView()
    
    private(set) var state: State = .normal
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add paging footer
        footerView.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: footerView.intrinsicContentSize.height)
    }
    
    // MARK: Data
    
    func updatePagingAbility(canPage: Bool) {
        self.tableView.tableFooterView = canPage ? self.footerView : UIView()
    }
    
    func loadNextPageOfData() {
        attemptLoadNextPageOfData(newState: .loading)
    }
    
    private func attemptLoadNextPageOfData(newState: State) {
        guard state == .normal else { return }
        
        self.state = newState
        loadNextPageOfData { (success, allowPaging) in
            self.state = .normal
            
            self.footerView.stopAnimating()
            self.updatePagingAbility(canPage: allowPaging)
        }
    }
    
    func loadNextPageOfData(completion: @escaping ((_ success: Bool, _ allowPaging: Bool) -> Void)) {
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        checkIfPagingLoadRequired()
    }
    
    /// Checks if table view has reached bottom for page load.
    private func checkIfPagingLoadRequired() {
        guard self.tableView.tableFooterView == self.footerView else { return }
        
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.bounds.size.height) {
            
            attemptLoadNextPageOfData(newState: .paging)
        }
    }
}
