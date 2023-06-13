//
//  ChildViewController.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import RIBs
import UIKit
import SwiftUI

final class ChildViewController: UIHostingController<ChildView>, ChildViewControllable {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Child"

        if presentingViewController != nil {
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(title: "Close",
                style: .plain,
                target: self,
                action: #selector(didTapRightBarButton(_:)))
            ]
            rootView.presenter.action(.showCloseButton)
        } else {
        }

    }

    @objc private func didTapRightBarButton(_ sender: UIBarButtonItem) {
        rootView.presenter.action(.didTapClose)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            rootView.presenter.action(.didTapBack)
        }
    }
}
