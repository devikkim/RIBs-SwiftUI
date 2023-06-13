//
//  RootComponent+Child.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import RIBs

protocol RootDependencyChild: Dependency {}

extension RootComponent: ChildDependency {}
