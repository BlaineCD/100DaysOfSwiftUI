//
//  ContentView.swift
//  ImagePaint
//
//  Created by Blaine Dannheisser on 1/20/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Text("Hello, world!")
//            .border(ImagePaint(image: Image("Example"), scale: 0.2), width: 30)
//            .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
        Capsule()
            .strokeBorder(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.85, width: 1, height: 0.2), scale: 0.3), lineWidth: 20)
            .frame(width: 300, height: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
