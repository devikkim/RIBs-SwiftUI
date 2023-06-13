//
//  RootRouter.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import RIBs
import UIKit

protocol RootInteractable: Interactable, ChildListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable { }

final class RootRouter: ViewableRouter<RootInteractable, RootViewControllable>, RootRouting {

    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        childBuilder: ChildBuildable
    ) {
        self.childBuilder = childBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func request(_ request: RootRoutingRequest) {
        switch request {
        case let .routeToChildAsPresent(count):
            routeToChildAsPresent(count)

        case .detachChildAsDismiss:
            detachChildAsDismiss()

        case let .routeToChildAsPush(count):
            routeToChildAsPush(count)

        case .detachChildAsPop:
            detachChildAsPop()

        case .showPopup:
            let alert = UIAlertController(title: "Did tap right bar item.", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Confirm", style: .default, handler: {[weak self] _ in
                self?.viewController.uiviewController.dismiss(animated: true)
            })
            alert.addAction(action)
            viewController.uiviewController.present(alert, animated: true)
        }
    }

    private let childBuilder: ChildBuildable
    private var childRouter: ViewableRouting?

    private func routeToChildAsPresent(_ count: Int) {
        guard childRouter == nil else { return }
        let router = childBuilder.build(
            withListener: interactor,
            count: count
        )
        childRouter = router
        attachChild(router)

        let naviVC = UINavigationController(rootViewController: router.viewControllable.uiviewController)
        naviVC.modalPresentationStyle = .overFullScreen
        viewController.uiviewController.present(naviVC, animated: true)
    }

    private func detachChildAsDismiss() {
        guard let childRouter else { return }
        self.childRouter = nil
        detachChild(childRouter)

        viewController.uiviewController.dismiss(animated: true)
    }

    private func routeToChildAsPush(_ count: Int) {
        guard childRouter == nil else { return }
        let router = childBuilder.build(
            withListener: interactor,
            count: count
        )
        childRouter = router
        attachChild(router)

        viewController.uiviewController.navigationController?.pushViewController(router.viewControllable.uiviewController, animated: true)
    }

    private func detachChildAsPop() {
        guard let childRouter else { return }
        self.childRouter = nil
        detachChild(childRouter)

        viewController.uiviewController.navigationController?.popViewController(animated: true)
    }
}
