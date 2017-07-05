//
//  AppDelegate.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let configPlist = Bundle(for: type(of: self)).path(forResource: "Config", ofType: "plist")!
        let config = AppConfig(with: NSDictionary(contentsOfFile: configPlist) as! [String : Any])
        
        let requestBuilder = RequestBuilder(with: config)
        let requestExecutor = RequestExecutor()
        
        if let request = requestBuilder.build(for: .topTracks, method: .get) {
            requestExecutor.execute(request, success: { (request, response, data) in
                
            }, failure: { (request, response, error) in
                dump(error)
            })
        }
        
        return true
    }
}

