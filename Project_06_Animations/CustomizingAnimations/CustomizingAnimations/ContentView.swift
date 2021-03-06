//
//  ContentView.swift
//  CustomizingAnimations
//
//  Created by Blaine Dannheisser on 1/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
            //            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        )
        .onAppear {
            animationAmount = 2
        }
        //        .scaleEffect(animationAmount)
        //        .blur(radius: (animationAmount - 1) * 3)

        //        .animation(.easeOut, value: animationAmount)
        //        .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
        //        .animation(
        //            .easeInOut(duration: 2)
        //                .repeatForever(autoreverses: true),
        //            value: animationAmount)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
