//
//  RootViewController.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var backgroundGradientView: GradientView!
    @IBOutlet weak var backgroundAlbumArtView: AlbumArtBackgroundView!
    
    // MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundGradientView.colors = UIColor.hta_backgroundGradient
    }
}
