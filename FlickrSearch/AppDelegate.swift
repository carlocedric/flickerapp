//
//  AppDelegate.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var mainCoordinator: RouterContract?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        mainCoordinator = PhotosSearchRouter(navigationController: navigationController)
        mainCoordinator?.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

