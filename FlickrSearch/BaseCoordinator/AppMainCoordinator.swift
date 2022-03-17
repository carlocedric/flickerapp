//
//  AppMainCoordinator.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

import UIKit

class AppMainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        
        let coordinator = MoviesListViewCoordinator(navigationController: navigationController,
                                                    dependencies: MoviesSceneDIContainer(dependencies: appDIContainer))
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

