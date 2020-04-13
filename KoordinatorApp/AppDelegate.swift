//
//  AppDelegate.swift
//  Koordinator
//
//  Created by Andrea Mugnaini on 11/04/2020.
//  Copyright © 2020 Andrea Mugnaini. All rights reserved.
//

import UIKit

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var tabBarCoordinator: DemoTabBarCoordinator?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow()
        setupRootViewController()
    }

    private func setupRootViewController() {
        tabBarCoordinator = DemoTabBarCoordinator(presenter: window)
        tabBarCoordinator?.start()
    }
}

