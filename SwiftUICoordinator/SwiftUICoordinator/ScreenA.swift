import SwiftUI

@MainActor @Observable
class ScreenAViewModel {

    let nextTapped: () -> Void
    let doneTapped: () -> Void
    
    enum Action {
        case nextTapped
        case doneTapped
    }
    
    init(nextTapped: @escaping () -> Void,
         doneTapped: @escaping () -> Void) {
        self.nextTapped = nextTapped
        self.doneTapped = doneTapped
    }
    
    func handle(action: Action) {
        switch action {
        case .nextTapped:
            nextTapped()
        case .doneTapped:
            doneTapped()
        }
    }
}
extension ScreenAViewModel: Hashable {}

struct ScreenA: View {
    @Bindable var viewModel: ScreenAViewModel
    
    var body: some View {
        VStack {
            Text("Hello A World!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button("Next") {
                viewModel.handle(action: .nextTapped)
            }
            
            Button("Done") {
                viewModel.handle(action: .doneTapped)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
        .navigationTitle("Screen A")
    }
}

