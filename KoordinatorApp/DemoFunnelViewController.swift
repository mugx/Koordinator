//
//  DemoFunnelViewController.swift
//  Koordinator
//
//  Created by Andrea Mugnaini on 11/04/2020.
//  Copyright © 2020 Andrea Mugnaini. All rights reserved.
//

import UIKit

protocol DemoFunnelViewControllerDelegate: BaseViewControllerDelegate {
    func presentRandomFunnel()
    func pushRandomFunnel()
    func getStatus() -> String?
}

class DemoFunnelViewController: BaseViewController {
    weak var delegate: DemoFunnelViewControllerDelegate?
    let type: FunnelType

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        label.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.layer.cornerRadius = 6
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    private lazy var presentDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("PRESENT random funnel", for: .normal)
        button.addTarget(self, action: #selector(presentDetailTapped), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 6
        return button
    }()

    private lazy var pushDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("PUSH random funnel", for: .normal)
        button.addTarget(self, action: #selector(pushDetailTapped), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 6
        return button
    }()
    
    init(delegate: DemoFunnelViewControllerDelegate, type: FunnelType) {
        self.delegate = delegate
        self.type = type

        super.init(delegate: delegate)

        title = "Funnel \(type.rawValue)"
    }

    deinit {
        print("deinit::DemoFunnelViewController::\(type)")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = getColor()
        setupComponents()
    }

    private func getColor() -> UIColor? {
        switch type {
        case .funnel1: return .blue
        case .funnel2: return .purple
        case .funnel3: return .magenta
        }
    }

    private func setupComponents() {
        view.addSubview(statusLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(presentDetailButton)
        stackView.addArrangedSubview(pushDetailButton)

        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            statusLabel.widthAnchor.constraint(equalToConstant: 310),
            statusLabel.heightAnchor.constraint(equalToConstant: 80),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            presentDetailButton.widthAnchor.constraint(equalToConstant: 310),
            presentDetailButton.heightAnchor.constraint(equalToConstant: 44),
            pushDetailButton.widthAnchor.constraint(equalTo: presentDetailButton.widthAnchor),
            pushDetailButton.heightAnchor.constraint(equalTo: presentDetailButton.heightAnchor)

        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        statusLabel.text = delegate?.getStatus()
    }

    // MARK: - Actions

    @objc private func presentDetailTapped() {
        delegate?.presentRandomFunnel()
    }

    @objc private func pushDetailTapped() {
        delegate?.pushRandomFunnel()
    }
}
