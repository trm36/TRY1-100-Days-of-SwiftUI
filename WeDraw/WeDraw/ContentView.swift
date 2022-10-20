//
//  ContentView.swift
//  WeDraw
//
//  Created by Taylor on 15 October 2022.
//

import SwiftUI

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    @State private var colorCycle = 0.0
    
    var body: some View {
        //        VStack(spacing: 50) {
        //            Triangle()
        //                .stroke(.green, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        ////                .fill(.red)
        //                .frame(width: 150, height: 150)
        //
        //            Arc(startAngle: .degrees(0),
        //                endAngle: .degrees(110),
        //                clockwise: true)
        ////            .strokeBorder(.blue, lineWidth: 40.0)
        //            .stroke(.blue, lineWidth: 10)
        //            .frame(width: 150, height: 150)
        //
        //            Circle()
        //                .strokeBorder(.blue, lineWidth: 30)
        //                .frame(width: 150, height: 150)
        //
        //            Flower()
        //                .frame(width: 150, height: 150)
        //        }
        //        .padding()
        
//        VStack {
//            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
////                .stroke(.red, lineWidth: 1)
//                .fill(.red,  style: FillStyle(eoFill: true))
//
//            Text("Offset")
//            Slider(value: $petalOffset, in: -40...40)
//                .padding([.horizontal, .bottom])
//
//            Text("Width")
//            Slider(value: $petalWidth, in: 0...100)
//                .padding(.horizontal)
//        }
        
//        VStack {
//            Text("Hello World")
//                .frame(width: 300, height: 300)
//                .border(ImagePaint(image: Image("example"), scale: 0.2), width: 30)
//
//            Text("Hello World")
//                .frame(width: 300, height: 300)
//                .border(ImagePaint(image: Image("example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
//
//            Capsule()
//                .strokeBorder(ImagePaint(image: Image("example"), scale: 0.1), lineWidth: 20)
//                .frame(width: 300, height: 200)
//        }
        
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount = 0.0

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2 - insetAmount,
                    startAngle: modifiedStart,
                    endAngle: modifiedEnd,
                    clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20

    // How wide to make each petal
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()

        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)

            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))

            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)

            // add it to our main path
            path.addPath(rotatedPetal)
        }

        // now send the main path back
        return path
    }
}

//struct SpikeBall: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
//            let rotation = CGAffineTransform(rotationAngle: number)
//            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
//
//            let petal = Path { path in
//                path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//                path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
//            }
//
//            let rotatedPetal = petal.applying(position)
//            path.addPath(rotatedPetal)
//        }
//
//        return path
//    }
//}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps: Int = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps, id: \.self) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
