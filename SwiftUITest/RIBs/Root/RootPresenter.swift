//
//  RootPresenter.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import UIKit
import SwiftUI

enum RootPresentableListenerRequest {
    case didTapRightBarButton
    case didTapIncreaseButton
    case didTapDecreaseButton
    case didTapPresentButton(Int)
    case didTapPushButton(Int)
}

protocol RootPresentableListener: AnyObject {
    func request(_ request: RootPresentableListenerRequest)
}

class RootPresenter: RootPresentable, RootViewListener {
    weak var listener: RootPresentableListener?

    @Published var count: Int

    init(
        listener: RootPresentableListener? = nil,
        count: Int
    ) {
        self.listener = listener
        self.count = count
    }

    // MARK: - RootViewListener
    func action(_ action: RootViewAction) {
        switch action {
        case .didTapRightBarItem:
            listener?.request(.didTapRightBarButton)

        case .didTapIncrease:
            listener?.request(.didTapIncreaseButton)

        case .didTapDecrease:
            listener?.request(.didTapDecreaseButton)

        case .didTapPresent:
            listener?.request(.didTapPresentButton(count))

        case .didTapPush:
            listener?.request(.didTapPushButton(count))
        }
    }

    // MARK: - RootPresentable
    func request(_ request: RootPresentableRequest) {
        switch request {
        case let .increase(amount):
            count += amount
        case let .decrease(amount):
            count -= amount
        }
    }
}
