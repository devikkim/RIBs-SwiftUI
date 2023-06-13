//
//  ChildPresenter.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import UIKit
import SwiftUI

enum ChildPresentableListenerRequest {
    case didTapIncreaseButton
    case didTapDecreaseButton
    case didTapCloseButton
    case didTapBackButton
}

protocol ChildPresentableListener: AnyObject {
    func request(_ request: ChildPresentableListenerRequest)
}

class ChildPresenter: ChildPresentable, ChildViewListener {
    weak var listener: ChildPresentableListener?

    @Published var count: Int
    @Published var showCloseButton = false

    init(
        listener: ChildPresentableListener? = nil,
        count: Int
    ) {
        self.listener = listener
        self.count = count
    }

    // MARK: - ChildViewListener
    func action(_ action: ChildViewAction) {
        switch action {
        case .didTapIncrease:
            listener?.request(.didTapIncreaseButton)

        case .didTapDecrease:
            listener?.request(.didTapDecreaseButton)

        case .didTapClose:
            listener?.request(.didTapCloseButton)

        case .didTapBack:
            listener?.request(.didTapBackButton)

        case .showCloseButton:
            showCloseButton = true
        }
    }

    // MARK: - ChildPresentable
    func request(_ request: ChildPresentableRequest) {
        switch request {
        case .increase(let amount):
            count += amount
        case .decrease(let amount):
            count -= amount
        }
    }
}
