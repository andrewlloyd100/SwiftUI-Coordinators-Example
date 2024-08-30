//
//  ScreenB.swift
//  SwiftUICoordinator
//
//  Created by Andrew Lloyd on 19/01/2023.
//

import SwiftUI

protocol ScreenBViewModelDelegate {
    func goToC()
}

class ScreenBViewModel: ObservableObject, Hashable {
 
    var delegate: ScreenBViewModelDelegate?
    
    func onTapC() {
        delegate?.goToC()
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
                    viewModel.onTapC()
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
