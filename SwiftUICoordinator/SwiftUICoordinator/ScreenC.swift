//
//  ScreenB.swift
//  SwiftUICoordinator
//
//  Created by Andrew Lloyd on 19/01/2023.
//

import SwiftUI

struct ScreenC: View {
    var body: some View {
        Text("Hello C World!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.yellow)
    }
}

struct ScreenC_Previews: PreviewProvider {
    static var previews: some View {
        ScreenC()
    }
}
