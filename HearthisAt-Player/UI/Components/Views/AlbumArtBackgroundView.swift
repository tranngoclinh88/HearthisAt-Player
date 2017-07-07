//
//  AlbumArtBackgroundView.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 06/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import TinyConstraints
import AlamofireImage

class AlbumArtBackgroundView: ViewComponent {
    
    // MARK: Properties
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let overlayView: UIView = {
        let overlayView = UIView()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        return overlayView
    }()
    
    var imageUrl: URL? {
        didSet {
            guard let imageUrl = imageUrl else {
                imageView.image = nil
                return
            }
            
            imageView.af_setImage(withURL: imageUrl,
                                  placeholderImage: nil,
                                  imageTransition: .crossDissolve(0.6),
                                  runImageTransitionIfCached: true,
                                  completion: nil)
        }
    }
    
    // MARK: Lifecycle
    
    override func construct(in view: UIView) {
        super.construct(in: view)
        
        view.addSubview(imageView)
        imageView.edges(to: view)
        
        view.addSubview(blurView)
        blurView.edges(to: view)
        
        view.addSubview(overlayView)
        overlayView.edges(to: view)
    }
}
