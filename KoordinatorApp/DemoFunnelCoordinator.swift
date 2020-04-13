//
//  DemoFunnelCoordinator.swift
//  KoordinatorApp
//
//  Created by Andrea Mugnaini on 11/04/2020.
//  Copyright © 2020 Andrea Mugnaini. All rights reserved.
//

import UIKit

enum FunnelType: String, CaseIterable {
    case funnel1 = "1"
    case funnel2 = "2"
    case funnel3 = "3"

    func randomize() -> FunnelType {
        let cases = FunnelType.allCases.filter { $0 != self }
        return cases.randomElement()!
    }
}

class DemoFunnelCoordinator: BaseCoordinator {
    private let type: FunnelType
    private let navigationController: UINavigationController

    init(presenter: Presenter?, type: FunnelType) {
        self.type = type
        self.navigationController = presenter as? UINavigationController ?? UINavigationController()

        super.init(presenter: presenter)
    }

    deinit {
        print("deinit::DemoFunnelCoordinator::\(type)")
    }
    
    override func start() {
        var viewControllerToShow: UIViewController = DemoFunnelViewController(delegate: self, type: type)

        if navigationController.viewControllers.isEmpty {
            navigationController.show(viewControllerToShow)
            viewControllerToShow = navigationController
        }

        show(viewControllerToShow)
    }
}

// MARK: - DemoFunnelViewControllerDelegate

extension DemoFunnelCoordinator: DemoFunnelViewControllerDelegate {
    func presentRandomFunnel() {
        let coordinator = DemoFunnelCoordinator(
            presenter: navigationController.visibleViewController,
            type: type.randomize()
        )
        start(child: coordinator)
    }

    func pushRandomFunnel() {
        let coordinator = DemoFunnelCoordinator(
            presenter: navigationController,
            type: type.randomize()
        )
        start(child: coordinator)
    }

    func getStatus() -> String? {
        switch presenter {
        case is UITabBarController:
            return "Funnel = \(type.rawValue)\nPresenter = UITabBarController"
        case is UINavigationController:
            return "Funnel = \(type.rawValue)\nPresenter = UINavigationController"
        case is UIViewController:
            return "Funnel = \(type.rawValue)\nPresenter = UIViewController"
        default:
            return nil
        }
    }
}
