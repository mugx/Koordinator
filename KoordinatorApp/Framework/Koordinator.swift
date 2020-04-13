//
//  Koordinator.swift
//  KoordinatorApp
//
//  Created by Andrea Mugnaini on 12/04/2020.
//  Copyright © 2020 Andrea Mugnaini. All rights reserved.
//

import UIKit

protocol Koordinator {
    associatedtype Koordinator: Hashable

    var children: Set<Koordinator> { get set }
    var presenter: Presenter? { get set }

    func start()
    func start(child: Koordinator)
    func show(_ viewController: UIViewController)
}
