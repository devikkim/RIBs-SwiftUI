//
//  ChildBuilder.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import RIBs

protocol ChildDependency: Dependency {}

final class ChildComponent: Component<ChildDependency> {}

// MARK: - Builder

protocol ChildBuildable: Buildable {
    func build(withListener listener: ChildListener, count: Int) -> ChildRouting
}

final class ChildBuilder: Builder<ChildDependency>, ChildBuildable {

    override init(dependency: ChildDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ChildListener, count: Int) -> ChildRouting {
        _ = ChildComponent(dependency: dependency)
        let presenter = ChildPresenter(count: count)
        let viewController = ChildViewController(rootView: ChildView(presenter: presenter))
        let interactor = ChildInteractor(presenter: presenter)
        interactor.listener = listener
        return ChildRouter(interactor: interactor, viewController: viewController)
    }
}
