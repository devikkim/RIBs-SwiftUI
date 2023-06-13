//
//  ChildRouter.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import RIBs

protocol ChildInteractable: Interactable {
    var router: ChildRouting? { get set }
    var listener: ChildListener? { get set }
}

protocol ChildViewControllable: ViewControllable { }

final class ChildRouter: ViewableRouter<ChildInteractable, ChildViewControllable>, ChildRouting {
    override init(interactor: ChildInteractable, viewController: ChildViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
