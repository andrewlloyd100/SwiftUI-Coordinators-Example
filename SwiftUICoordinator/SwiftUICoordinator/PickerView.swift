import UIKit
import SwiftUI
import PhotosUI

struct PickerView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        return picker

    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
}
