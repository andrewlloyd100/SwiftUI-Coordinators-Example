import SwiftUI

@MainActor @Observable
class CoordinatorModel {
    var path: [Destination]
    
    enum Destination: Hashable {
        case bScreen(ScreenBViewModel)
        case cScreen(ScreenCViewModel)
    }
    
    enum SheetState: String, Identifiable {
        case pickerModal
        case helloWorld
        
        var id: String {
            return self.rawValue
        }
    }
    
    var rootViewModel: ScreenAViewModel?
    var sheetState: SheetState?
    
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
        let cViewModel = ScreenCViewModel(goHome: popToRoot, goPicker: goToPicker, goHelloWorld: goToHelloWorld)
        path.append(Destination.cScreen(cViewModel))
    }
    
    private func popToRoot() {
        path.removeAll()
    }
    
    private func goToPicker() {
        sheetState = .pickerModal
    }
    
    private func goToHelloWorld() {
        sheetState = .helloWorld
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
                  }
                }
                .navigationTitle("SwiftUI Coordinators")
        }
        .sheet(item: $coordinatorModel.sheetState) { item in
            switch item {
            case .pickerModal:
                PickerView()
            case .helloWorld:
                Text("Hello World")
            }
        }
    }
}

struct Coordinator_Previews: PreviewProvider {
    static var previews: some View {
        Coordinator(coordinatorModel: CoordinatorModel())
    }
}
