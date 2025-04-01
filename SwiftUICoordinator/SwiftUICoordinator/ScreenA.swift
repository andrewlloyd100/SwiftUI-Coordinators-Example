//
//  ScreenA.swift
//  SwiftUICoordinator
//
//  Created by Andrew Lloyd on 19/01/2023.
//

import SwiftUI

protocol ScreenAViewModelDelegate {
    func navigateTo(destination: ScreenAViewModel.Destination)
}

class ScreenAViewModel: ObservableObject, Hashable {
    var coordinatorDelegate: ScreenAViewModelDelegate?
    
    enum Action {
        case tapB
        case tapC
    }
    
    enum Destination {
        case b
        case c
    }
    
    func handle(action: Action) {
        switch action {
        case .tapB:
            tapB()
        case .tapC:
            tapC()
        }
    }
    
    private func tapB() {
        coordinatorDelegate?.navigateTo(destination: .b)
    }
    
    private func tapC() {
        coordinatorDelegate?.navigateTo(destination: .c)
    }
}

struct ScreenA: View {
    @ObservedObject var viewModel: ScreenAViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text("Hello A World!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                Button("Go To B") {
                    viewModel.handle(action: .tapB)
                }
                
                Button("Go To C") {
                    viewModel.handle(action: .tapC)
                }
                Spacer()
            }
            
        }
        .background(.red)
        
    }
}

struct ScreenA_Previews: PreviewProvider {
    static var previews: some View {
        ScreenA(viewModel: ScreenAViewModel())
    }
}
