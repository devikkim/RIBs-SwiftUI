//
//  RootBuilder.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import RIBs

protocol RootDependency: Dependency { }

final class RootComponent: Component<RootDependency> { }

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build(withListener listener: RootListener) -> RootRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RootListener) -> RootRouting {
        let component = RootComponent(dependency: dependency)
        let presenter = RootPresenter(count: 0)
        let viewController = RootViewController(rootView: RootView(presenter: presenter))
        let interactor = RootInteractor(presenter: presenter)
        interactor.listener = listener

        let childBuilder = ChildBuilder(dependency: component)

        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            childBuilder: childBuilder
        )
    }
}
