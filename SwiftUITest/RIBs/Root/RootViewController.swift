//
//  RootViewController.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import RIBs
import UIKit
import SwiftUI

class RootViewController: UIHostingController<RootView>, RootViewControllable {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Root"

        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Popup", style: .plain, target: self, action: #selector(didTapRightBarButton(_:)))]
    }

    @objc private func didTapRightBarButton(_ sender: UIBarButtonItem) {
        rootView.presenter.action(.didTapRightBarItem)
    }
}
