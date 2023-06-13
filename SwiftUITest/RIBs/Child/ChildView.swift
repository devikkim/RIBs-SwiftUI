//
//  ChildView.swift
//  SwiftUITest
//
//  Created by todd.kim on 2023/06/13.
//

import SwiftUI

enum ChildViewAction {
    case didTapIncrease
    case didTapDecrease
    case didTapClose
    case didTapBack
    case showCloseButton
}

protocol ChildViewListener: ObservableObject {
    func action(_ action: ChildViewAction)
}

struct ChildView: View {
    @ObservedObject var presenter: ChildPresenter

    init(presenter: ChildPresenter) {
        self.presenter = presenter
    }

    var body: some View {
        VStack {
            Text("Child SwiftUI View")
                .padding(.bottom, 30)

            Text("Parent's count is: \(presenter.count)")

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

            if presenter.showCloseButton {
                Button {
                    presenter.action(.didTapClose)
                } label: {
                    Text("Close")
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.black)
                .tint(.orange)
            }
        }
    }
}

struct ChildView_Previews: PreviewProvider {
    static var previews: some View {
        ChildView(presenter: ChildPresenter(count: 1))
    }
}
