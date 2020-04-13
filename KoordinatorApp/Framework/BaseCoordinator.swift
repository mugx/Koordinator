//
//  BaseCoordinator.swift
//  KoordinatorApp
//
//  Created by Andrea Mugnaini on 11/04/2020.
//  Copyright © 2020 Andrea Mugnaini. All rights reserved.
//

import UIKit

@objc protocol BaseCoordinatorParentDelegate: class {
    func remove(child coordinator: BaseCoordinator)
}

class BaseCoordinator: NSObject, Koordinator {
    var children: Set<BaseCoordinator> = []
    weak var parentCoordinatorDelegate: BaseCoordinatorParentDelegate?
    weak var presenter: Presenter?

    init(presenter: Presenter?) {
        self.presenter = presenter
    }

    func start() {
        fatalError("start() has not been implemented")
    }

    final func start(child: BaseCoordinator) {
        child.parentCoordinatorDelegate = self
        children.insert(child)
        child.start()
    }

    final func show(_ viewController: UIViewController) {
        presenter?.show(viewController)
    }
}

// MARK: - BaseCoordinatorParentDelegate

extension BaseCoordinator: BaseCoordinatorParentDelegate {
    func remove(child coordinator: BaseCoordinator) {
        children.remove(coordinator)
    }
}

// MARK: - BaseViewControllerDelegate

extension BaseCoordinator: BaseViewControllerDelegate {
    func viewControllerDidClose() {
        parentCoordinatorDelegate?.remove(child: self)
    }
}
