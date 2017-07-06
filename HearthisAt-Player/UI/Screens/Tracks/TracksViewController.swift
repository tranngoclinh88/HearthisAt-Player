//
//  TracksViewController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class TracksViewController: PagingTableViewController {
    
    // MARK: Properties
    
    var artist: User!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dump(service.tracksController.tracks(for: artist))
        
        if (service.tracksController.tracks(for: artist)?.count ?? 0) == 0 {
            service.tracksController.loadTracks(for: artist, pageIndex: 1, count: 20, success: { (tracks) in
                
            }) { (error) in
                
            }
        }
    }
}
