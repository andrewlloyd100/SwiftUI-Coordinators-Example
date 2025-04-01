//
//  ScreenB.swift
//  SwiftUICoordinator
//
//  Created by Andrew Lloyd on 19/01/2023.
//

import SwiftUI

protocol ScreenBViewModelDelegate {
    func navigateTo(destination: ScreenAViewModel.Destination)
}

class ScreenBViewModel: ObservableObject, Hashable {
 
    var coordinatorDelegate: ScreenBViewModelDelegate?
    
    enum Action {
        case tapC
    }
    
    enum Destination {
        case c
    }
    
    func handle(action: Action) {
        switch action {
        case .tapC:
            onTapC()
        }
    }
    
    private func onTapC() {
        coordinatorDelegate?.navigateTo(destination: .c)
    }
}

struct ScreenB: View {
    @ObservedObject var viewModel: ScreenBViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text("Hello B World!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
    
                Button("Go To C") {
                    viewModel.handle(action: .tapC)
                }
                Spacer()
            }
            
        }
        .background(.green)
    }
}

struct ScreenB_Previews: PreviewProvider {
    static var previews: some View {
        ScreenB(viewModel: ScreenBViewModel())
    }
}
