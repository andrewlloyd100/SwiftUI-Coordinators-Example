//
//  SwiftUICoordinatorApp.swift
//  SwiftUICoordinator
//
//  Created by Andrew Lloyd on 19/01/2023.
//

import SwiftUI

@main
struct SwiftUICoordinatorApp: App {
    var body: some Scene {
        WindowGroup {
            Coordinator(coordinatorModel: CoordinatorModel())
        }
    }
}
