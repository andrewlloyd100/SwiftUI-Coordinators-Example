import SwiftUI

@MainActor @Observable
final class ScreenCViewModel {
    
    let goHome: () -> Void
    let goPicker: () -> Void
    init(goHome: @escaping () -> Void,
         goPicker: @escaping () -> Void) {
        self.goHome = goHome
        self.goPicker = goPicker
    }
    
    enum Action {
        case goHomeTapped
        case goPickerTapped
    }
    
    func handle(action: Action) {
        switch action {
        case .goHomeTapped:
            goHome()
        case .goPickerTapped:
            goPicker()
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
