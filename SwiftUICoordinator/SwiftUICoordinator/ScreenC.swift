import SwiftUI

@MainActor @Observable
final class ScreenCViewModel {
    
    let goHome: () -> Void
    let goPicker: () -> Void
    let goHelloWorld: () -> Void
    
    init(goHome: @escaping () -> Void,
         goPicker: @escaping () -> Void,
         goHelloWorld: @escaping () -> Void
    ) {
        self.goHome = goHome
        self.goPicker = goPicker
        self.goHelloWorld = goHelloWorld
    }
    
    enum Action {
        case goHomeTapped
        case goPickerTapped
        case goHelloWorld
    }
    
    func handle(action: Action) {
        switch action {
        case .goHomeTapped:
            goHome()
        case .goPickerTapped:
            goPicker()
        case .goHelloWorld:
            goHelloWorld()
        }
    }
}
extension ScreenCViewModel: Hashable {}

struct ScreenC: View {
    @Bindable var viewModel: ScreenCViewModel
    
    var body: some View {
        VStack {
            Text("We're Done")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button("Hello World") {
                viewModel.handle(action: .goHelloWorld)
            }
            Button("Go Home") {
                viewModel.handle(action: .goHomeTapped)
            }
            Button("Go Picker") {
                viewModel.handle(action: .goPickerTapped)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
        .navigationTitle("Screen C")
    }
}
