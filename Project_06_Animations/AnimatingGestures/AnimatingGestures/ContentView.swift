//
//  ContentView.swift
//  AnimatingGestures
//
//  Created by Blaine Dannheisser on 1/9/22.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {

    @State private var dragAmount = CGSize.zero

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                //Explicit Animation:
                    .onEnded { _ in
                        withAnimation {
                            dragAmount = .zero
                        }
                    }
            )
        //Implicit Animation:
//            .animation(.spring(), value: dragAmount)
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
