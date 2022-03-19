//
//  ImagePicker.swift
//  Milestone_05_NameAndFace
//
//  Created by Blaine Dannheisser on 3/17/22.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    // MARK: Internal

    // nested to encapsulate functionality. Coordinator handles comms from the PHPickerViewController
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        // MARK: Lifecycle

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        // MARK: Internal

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // dismiss the picker
            picker.dismiss(animated: true)
            // exit if no selection made
            guard let provider = results.first?.itemProvider else { return }
            // use image if selected
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
