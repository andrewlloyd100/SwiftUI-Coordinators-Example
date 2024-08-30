//
//  ScreenA.swift
//  SwiftUICoordinator
//
//  Created by Andrew Lloyd on 19/01/2023.
//

import SwiftUI

protocol ScreenAViewModelDelegate {
    func goToB()
    func goToC()
}

class ScreenAViewModel: ObservableObject, Hashable {
    var delegate: ScreenAViewModelDelegate?
    
    
    func tapB() {
        delegate?.goToB()
    }
    
    func tapC() {
        delegate?.goToC()
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
                    viewModel.tapB()
                }
                
                Button("Go To C") {
                    viewModel.tapC()
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
