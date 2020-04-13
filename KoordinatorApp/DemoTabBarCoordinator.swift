//
//  TabBarCoordinator.swift
//  KoordinatorApp
//
//  Created by Andrea Mugnaini on 11/04/2020.
//  Copyright © 2020 Andrea Mugnaini. All rights reserved.
//

import UIKit

class DemoTabBarCoordinator: BaseCoordinator {
    override func start() {
        let tabBarController = UITabBarController()

        start(child: DemoFunnelCoordinator(presenter: tabBarController, type: .funnel1))
        start(child: DemoFunnelCoordinator(presenter: tabBarController, type: .funnel2))
        start(child: DemoFunnelCoordinator(presenter: tabBarController, type: .funnel3))

        show(tabBarController)
    }
}
