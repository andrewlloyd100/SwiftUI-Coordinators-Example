import SwiftUI

@main
struct SwiftUICoordinatorApp: App {
    @State var coordinatorModel: CoordinatorModel = .init()
    
    var body: some Scene {
        WindowGroup {
            Coordinator(coordinatorModel: coordinatorModel)
                .onAppear() {
                    coordinatorModel.goToEnd()
                }
        }
    }
}
