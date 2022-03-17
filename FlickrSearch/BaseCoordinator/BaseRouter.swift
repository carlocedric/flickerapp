//
//  BaseRouter.swift
//  FlickrSearch
//
//  Created by Carlo Cedric Lijauco on 17/03/2022.
//

import UIKit

class BaseRouter: RouterContract {

    private var children: [RouterContract] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: RouterContract?
    private var navigationStack: [UIViewController] = []
    var onCompleted: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        fatalError("Children should implement `start`.")
    }

    /// Navigation Actions on navigation controllers
    func show(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
        navigationStack.append(viewController)
    }

    func pop() {
        navigationController.popViewController(animated: true)
        if navigationStack.count > 0 {
            navigationStack.removeLast()
        }
        removeCoordinatorIfNeeded()
    }

    func popToRoot(withAnimation: Bool = true) {
        self.navigationController.popToRootViewController(animated: withAnimation)
        navigationStack.removeAll()
        removeCoordinatorIfNeeded()
    }

    func popTo(_ viewController: UIViewController) {
        let stack = navigationController.viewControllers
        if let index = stack.lastIndex(of: viewController) {
            navigationController.popToViewController(viewController, animated: true)
            if navigationStack.indices.contains(index) {
                navigationStack.removeLast(index)
            }
            removeCoordinatorIfNeeded()
        }
    }

    func popToVC(ofClass: AnyClass, animated: Bool = true) {
        let stack = navigationController.viewControllers
        if let viewcontroller = stack.last(where: { $0.isKind(of: ofClass) }) {
            navigationController.popToViewController(viewcontroller, animated: true)
            removeCoordinatorIfNeeded()
        }
    }

    private func removeCoordinatorIfNeeded() {
        if navigationStack.isEmpty {
            parentCoordinator?.free(coordinator: self)
        }
    }

    func store(coordinator: RouterContract) {
        children.append(coordinator)
    }

    func free(coordinator: RouterContract) {

        if let index = children.firstIndex( where: { $0 === coordinator }) {
        children.remove(at: index)
        }
    }

}

// MARK: - get the Viewcontroller from navigation stack
extension BaseRouter {

    func getViewcontroller<T: UIViewController>( controller: T.Type) -> T? {
        let stack = navigationController.viewControllers
        return stack.filter({ $0 is T }).first as? T
    }

    func viewControllerWithIdentifier(storyboardName: String, viewControllerId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController =
            storyboard.instantiateViewController(withIdentifier: viewControllerId)
        return viewController
    }
}
