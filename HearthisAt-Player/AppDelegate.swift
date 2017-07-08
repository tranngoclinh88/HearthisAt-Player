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
    private(set) var service: Service?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let configPlist = Bundle(for: type(of: self)).path(forResource: "Config", ofType: "plist")!
        let config = AppConfig(with: NSDictionary(contentsOfFile: configPlist) as! [String : Any])
        
        let requestBuilder = RequestBuilder(with: config)
        let requestExecutor = RequestExecutor()
        
        self.service = Service(with: config,
                               requestBuilder: requestBuilder,
                               requestExecutor: requestExecutor,
                               controllerFactoryType: ApiControllerFactory.self)
    
        return true
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        service?.playbackController.respondToRemoteControlEvent(event)
    }
}

