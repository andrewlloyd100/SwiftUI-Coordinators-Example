//
//  Coordinator.swift
//  SwiftUICoordinator
//
//  Created by Andrew Lloyd on 19/01/2023.
//

import SwiftUI

class CoordinatorModel: ObservableObject{
    @Published var path: [Destination] = []
    
    enum Destination: Hashable {
        case bScreen(ScreenBViewModel)
        case cScreen
    }
    
    let rootViewModel: ScreenAViewModel
    
    init() {
        rootViewModel = ScreenAViewModel()
        rootViewModel.delegate = self
    }
    
    func goToB() {
        let bViewModel = ScreenBViewModel()
        bViewModel.delegate = self
        path.append(Destination.bScreen(bViewModel))
    }
    
    func goToC() {
        path.append(Destination.cScreen)
    }
}
extension CoordinatorModel: ScreenAViewModelDelegate, ScreenBViewModelDelegate {}

struct Coordinator: View {
    
    @ObservedObject var coordinatorModel: CoordinatorModel
    
    var body: some View {
        NavigationStack(path: self.$coordinatorModel.path) {
            ScreenA(viewModel: coordinatorModel.rootViewModel)
                .navigationDestination(for: CoordinatorModel.Destination.self) { destination in
                  switch destination {
                  case let .bScreen(model):
                    ScreenB(viewModel: model)
                  case .cScreen:
                    ScreenC()
                  }
                }
                .navigationTitle("SwiftUI Coordinators")
        }
    }
}

struct Coordinator_Previews: PreviewProvider {
    static var previews: some View {
        Coordinator(coordinatorModel: CoordinatorModel())
    }
}
