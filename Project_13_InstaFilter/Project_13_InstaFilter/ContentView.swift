//
//  ContentView.swift
//  Project_13_InstaFilter
//
//  Created by Blaine Dannheisser on 3/2/22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }
}

    // MARK: - ContentView_Previews

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

    //struct ContentView: View {
    //    @State private var image: Image?
    //
    //    var body: some View {
    //        VStack {
    //            image?
    //                .resizable()
    //                .scaledToFit()
    //        }
    //        .onAppear(perform: loadImage)
    //    }
    //
    //    // MARK: Internal
    //
    //    func loadImage() {
    //        guard let inputImage = UIImage(named: "example") else { return }
    //        let beginImage = CIImage(image: inputImage)
    //
    //        // Create Core Image Context and Core Image Filter
    //        // Contexts handles converting processed data into a CGImage
    //        let context = CIContext()
    //
    //        let currentFilter = CIFilter.twirlDistortion()
    //        currentFilter.inputImage = beginImage
    //
    //        let amount = 1.0
    //        let inputKeys = currentFilter.inputKeys
    //
    //        if inputKeys.contains(kCIInputIntensityKey) {
    //            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
    //        }
    //
    //        if inputKeys.contains(kCIInputRadiusKey) {
    //            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
    //
    //        }
    //
    //        if inputKeys.contains(kCIInputScaleKey) {
    //            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
    //        }
    //
    //        // Convert output from filter to SwiftUI Image
    //        // 1) get at CIImage from our filter or exit if fails
    //        guard let outputImage = currentFilter.outputImage else { return }
    //        // 2) attempt to get a CGImage from our CIImage
    //        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
    //            // 3) convert that to a UIImage
    //            let uiImage = UIImage(cgImage: cgimg)
    //            // 4) convert to a swiftUI image
    //            image = Image(uiImage: uiImage)
    //        }
    //    }
    //}
