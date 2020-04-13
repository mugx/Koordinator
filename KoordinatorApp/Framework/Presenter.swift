//
//  Presenter.swift
//  Koordinator
//
//  Created by Andrea Mugnaini on 11/04/2020.
//  Copyright © 2020 Andrea Mugnaini. All rights reserved.
//

import UIKit

/**
 Presenter is the entity that shows the view controller. If the presenter is a:
 - `UIViewController`: the view controller is presented
 - `UINavigationViewController`: the view controller is pushed
 - `UITabBarController`: the view controller is appended as a new tab
 - `UIWindow`: the view controller becomes the root
 */
protocol Presenter: class {
    func show(_ viewController: UIViewController)
}

extension UIViewController: Presenter {
    func show(_ viewController: UIViewController) {
        if let tabBarController = self as? UITabBarController {
            var viewControllers = tabBarController.viewControllers ?? []
            viewControllers.append(viewController)
            tabBarController.viewControllers = viewControllers
        } else if let navigationController = self as? UINavigationController,
            viewController is UINavigationController == false {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            present(viewController, animated: true)
        }
    }
}

extension UIWindow: Presenter {
    func show(_ viewController: UIViewController) {
        rootViewController = viewController
        makeKeyAndVisible()
    }
}
