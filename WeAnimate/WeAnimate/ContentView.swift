//
//  ContentView.swift
//  WeAnimate
//
//  Created by Taylor on 09 September 2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        
        // MARK: ANIMATION: INTRODUCTION + CREATING IMPLICIT ANIMATIONS
        
        
//        Button("Tap Me") {
//            animationAmount += 1.0
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .scaleEffect(animationAmount)
//        .blur(radius: (animationAmount - 1) * 3)
//        .animation(.default, value: animationAmount)
//        .animation(.easeOut, value: animationAmount)
//        .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
//        .animation(.easeInOut(duration: 2), value: animationAmount)
//        .animation(
//            .easeInOut(duration: 2)
//                .delay(1),
//            value: animationAmount
//        )
//        .animation(
//            .easeInOut(duration: 1)
//                .repeatCount(3, autoreverses: true),
//            value: animationAmount
//        )
        
        
        // MARK: CUSTOMIZING ANIMATIONS IN SWIFT UI
        
        
//        Button("Tap Me Too") { }
//            .padding(50)
//            .background(.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .overlay(
//                Circle()
//                    .stroke(.blue)
//                    .scaleEffect(animationAmount)
//                    .opacity(2 - animationAmount)
//                    .animation(
//                        .easeOut(duration: 1)
//                        .repeatForever(autoreverses: false),
//                        value: animationAmount
//                    )
//            )
//            .onAppear {
//                animationAmount = 2
//            }
        
        
        // MARK: ANIMATING BINDINGS
        
        
//        print(animationAmount)
//
//        return VStack {
//            Stepper("Scale amount", value: $animationAmount.animation(
//                .easeInOut(duration: 1)
//                    .repeatCount(3, autoreverses: true)
//            ), in: 1...10)
//
//            Spacer()
//
//            Button("Tap Me 3") {
//                animationAmount += 1
//            }
//            .padding(40)
//            .background(.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//        }
        
        
        // MARK: CREATING EXPLICT ANIMATIONS
        
        
        Button("Tap Me 4") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
