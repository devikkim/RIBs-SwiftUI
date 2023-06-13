//
//  RootView.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import SwiftUI

enum RootViewAction {
    case didTapRightBarItem
    case didTapIncrease
    case didTapDecrease
    case didTapPresent
    case didTapPush
}

protocol RootViewListener: ObservableObject {
    func action(_ action: RootViewAction)
}

struct RootView: View {
    @ObservedObject var presenter: RootPresenter

    init(presenter: RootPresenter) {
        self.presenter = presenter
    }

    var body: some View {
        VStack {
            Text("Root SwiftUI View")
                .padding(.bottom, 30)

            Text("count is: \(presenter.count)")

            HStack {
                Button {
                    presenter.action(.didTapIncrease)
                } label: {
                    Text("Increase")
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.black)
                .tint(.yellow)

                Button {
                    presenter.action(.didTapDecrease)
                } label: {
                    Text("Decrease")
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.black)
                .tint(.blue)
            }

            Button {
                presenter.action(.didTapPresent)
            } label: {
                Text("Present")
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.black)
            .tint(.orange)

            Button {
                presenter.action(.didTapPush)
            } label: {
                Text("Push")
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.black)
            .tint(.red)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(presenter: RootPresenter(count: 10))
    }
}

