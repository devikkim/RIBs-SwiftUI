//
//  ChildInteractor.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import RIBs
import RxSwift

protocol ChildRouting: ViewableRouting {}

enum ChildPresentableRequest {
    case increase(amount: Int)
    case decrease(amount: Int)
}

protocol ChildPresentable: Presentable {
    var listener: ChildPresentableListener? { get set }
    func request(_ request: ChildPresentableRequest)
}

enum ChildListenerRequest {
    case dismiss
    case pop
}

protocol ChildListener: AnyObject {
    func request(_ request: ChildListenerRequest)
}

final class ChildInteractor: PresentableInteractor<ChildPresentable>, ChildInteractable, ChildPresentableListener {

    weak var router: ChildRouting?
    weak var listener: ChildListener?

    override init(presenter: ChildPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }

    func request(_ request: ChildPresentableListenerRequest) {
        switch request {
        case .didTapIncreaseButton:
            presenter.request(.increase(amount: 1))

        case .didTapDecreaseButton:
            presenter.request(.decrease(amount: 1))

        case .didTapCloseButton:
            listener?.request(.dismiss)

        case .didTapBackButton:
            listener?.request(.pop)
        }
    }

}
