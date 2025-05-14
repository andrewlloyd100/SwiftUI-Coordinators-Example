import SwiftUI

@MainActor @Observable
final class ScreenBViewModel {
    
    let doneTapped: () -> Void
    init(doneTapped: @escaping () -> Void) {
        self.doneTapped = doneTapped
    }
    
    enum Action {
        case doneTapped
    }
    
    func handle(action: Action) {
        switch action {
        case .doneTapped:
            doneTapped()
        }
    }
}
extension ScreenBViewModel: Hashable {}

struct ScreenB: View {
    @Bindable var viewModel: ScreenBViewModel
    
    var body: some View {
        VStack {
            Text("Hello B World!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button("Done") {
                viewModel.handle(action: .doneTapped)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        .navigationTitle("Screen B")
    }
}
