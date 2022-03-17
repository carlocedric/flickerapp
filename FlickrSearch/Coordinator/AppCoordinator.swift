//
//  AppCoordinator.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator {
    
    lazy var disposeBag: DisposeBag = {
            return DisposeBag()
        }()

    init(navigationController: UINavigationController?) {
        navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    override func start() -> UIViewController {
        return show()
    }
    private func show() -> UIViewController {
        removeChildCoordinators()
        let coordinator = AppDelegate.container.resolve(MoviesViewCoordinator.self)!
        return start(coordinator: coordinator)
    }
}
