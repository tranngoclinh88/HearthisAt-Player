//
//  FeedTransitioningHandler.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 07/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class FeedTransitioningHandler: NSObject {
    
    class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
        
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.3
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            let toViewController = transitionContext.viewController(forKey: .to)!
            let fromViewController = transitionContext.viewController(forKey: .from)!
            let containerView = transitionContext.containerView
            
            containerView.addSubview(toViewController.view)
            
            let viewWidth = fromViewController.view.frame.size.width
            toViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).translatedBy(x: viewWidth, y: 0.0)
            UIView.animate(withDuration: transitionDuration(using: transitionContext),
                           animations: {
                            
                            fromViewController.view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                            fromViewController.view.alpha = 0.0
                            
                            toViewController.view.transform = .identity
                            
            }) { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    
    class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
        
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.3
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            let toViewController = transitionContext.viewController(forKey: .to)!
            let fromViewController = transitionContext.viewController(forKey: .from)!
            let containerView = transitionContext.containerView
            
            let viewWidth = fromViewController.view.frame.size.width
            toViewController.view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            toViewController.view.alpha = 0.0
            
            containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)

            UIView.animate(withDuration: transitionDuration(using: transitionContext),
                           animations: { 
                            
                            fromViewController.view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).translatedBy(x: viewWidth, y: 0.0)
                            fromViewController.view.alpha = 0.0
                            
                            toViewController.view.alpha = 1.0
                            toViewController.view.transform = .identity
            }) { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}

extension FeedTransitioningHandler: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PushAnimator()
            
        case .pop:
            return PopAnimator()
            
        default:
            return nil
        }
    }
}
