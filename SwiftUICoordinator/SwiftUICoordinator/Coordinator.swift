import SwiftUI

@MainActor @Observable
class CoordinatorModel {
    var path: [Destination]
    
    enum Destination: Hashable {
        case bScreen(ScreenBViewModel)
        case cScreen(ScreenCViewModel)
        case pickerView
    }
    
    var rootViewModel: ScreenAViewModel?
    
    init(path: [Destination] = []) {
        self.path = path
        rootViewModel = ScreenAViewModel(nextTapped: goToB, doneTapped: goToC)
    }
    
    public func goToEnd() {
//        path = [.bScreen(ScreenBViewModel(doneTapped: goToC)),
//                .bScreen(ScreenBViewModel(doneTapped: goToC)),
//                .bScreen(ScreenBViewModel(doneTapped: goToC)),
//                .cScreen(ScreenCViewModel(goHome: popToRoot, goPicker: goToPicker))
//        ]
        goToB()
        goToC()
    }
    
    private func goToB() {
        let bViewModel = ScreenBViewModel(doneTapped: goToC)
        path.append(Destination.bScreen(bViewModel))
    }
    
    private func goToC() {
        let cViewModel = ScreenCViewModel(goHome: popToRoot, goPicker: goToPicker)
        path.append(Destination.cScreen(cViewModel))
    }
    
    private func popToRoot() {
        path.removeAll()
    }
    
    private func goToPicker() {
        path.append(.pickerView)
    }
}

struct Coordinator: View {
    
    @State var coordinatorModel: CoordinatorModel
    
    var body: some View {
        NavigationStack(path: self.$coordinatorModel.path) {
            ScreenA(viewModel: coordinatorModel.rootViewModel!)
                .navigationDestination(for: CoordinatorModel.Destination.self) { destination in
                  switch destination {
                  case let .bScreen(model):
                    ScreenB(viewModel: model)
                  case let .cScreen(model):
                      ScreenC(viewModel: model)
                  case .pickerView:
                      PickerView()
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
