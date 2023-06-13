//
//  RootInteractor.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import RIBs
import RxSwift

enum RootRoutingRequest {
    case showPopup
    case routeToChildAsPresent(Int)
    case detachChildAsDismiss
    case routeToChildAsPush(Int)
    case detachChildAsPop
}

protocol RootRouting: ViewableRouting {
    func request(_ request: RootRoutingRequest)
}

enum RootPresentableRequest {
    case increase(amount: Int)
    case decrease(amount: Int)
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    func request(_ request: RootPresentableRequest)
}

protocol RootListener: AnyObject { }

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }

    func request(_ request: RootPresentableListenerRequest) {
        switch request {
        case .didTapRightBarButton:
            router?.request(.showPopup)

        case .didTapIncreaseButton:
            presenter.request(.increase(amount: 1))

        case .didTapDecreaseButton:
            presenter.request(.decrease(amount: 1))

        case let .didTapPresentButton(count):
            router?.request(.routeToChildAsPresent(count))

        case let .didTapPushButton(count):
            router?.request(.routeToChildAsPush(count))
        }
    }
}

// MARK: - ChildListenerRequest
extension RootInteractor {
    func request(_ request: ChildListenerRequest) {
        switch request {
        case .dismiss:
            router?.request(.detachChildAsDismiss)
        case .pop:
            router?.request(.detachChildAsPop)
        }
    }
}
