//
//  BaseViewController.swift
//  KoordinatorApp
//
//  Created by Andrea Mugnaini on 11/04/2020.
//  Copyright © 2020 Andrea Mugnaini. All rights reserved.
//

import UIKit

protocol BaseViewControllerDelegate: class {
    func viewControllerDidClose()
}

/**
   BaseViewController helps to manage pop/dismiss callbacks to the BaseCoordinator
*/
class BaseViewController: UIViewController {
    private weak var delegate: BaseViewControllerDelegate?

    init(delegate: BaseViewControllerDelegate?) {
        self.delegate = delegate

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        (navigationController?.presentationController ?? presentationController)?.delegate = self
    }
}

// MARK: - Pop - UIContainerViewControllerCallbacks

extension BaseViewController {
     override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

        if parent == nil {
            delegate?.viewControllerDidClose()
        }
    }
}

// MARK: - Dismiss - UIAdaptivePresentationControllerDelegate

extension BaseViewController: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate?.viewControllerDidClose()
    }
}
