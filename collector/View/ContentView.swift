//
//  ContentView.swift
//  IntroAnimation
//
//  Created by Brian on 11/29/21.
//
//import SwiftUI
//import UIKit
//
//struct ContentView: View {
//    @State var endAmount : CGFloat = 0
//    @State var isFilled = false
//    @State var scaleReduced = false
//    @State var typePosition : CGFloat = 515
//    @State var typeOpacity : Double = 0
////    @State var animationComplete = false
//
//    let typeBounds = UIBezierPath.calculateBounds(paths: [.gFont,.aFont,.mFont,.eFont,.oFont, .lFont, .oFont2, .gFont2, .yFont])
//    let pathBounds = UIBezierPath.calculateBounds(paths: [.gLogoShape, .gLogoFill, .dPad, .roundButton1, .roundButton2, .roundButton3, .roundButton4])
//
//    var body: some View {
//
//        AnimatedBackground().edgesIgnoringSafeArea(.all)
//
//            .overlay(
//        VStack{
//            ZStack{
////            ZStack {
//            ZStack(alignment: SwiftUI.Alignment(horizontal: .center, vertical: .bottom)) {
//
////            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
//
//
//            ZStack{
//
//            Group {
//            ShapeView(bezier: .gLogoFill, pathBounds: pathBounds)
//                .trim(from: 0, to: endAmount)
//                .stroke(Color.white, lineWidth: 2)
//                .scaleEffect(scaleReduced ? 0.4 : 1)
//            ShapeView(bezier: .dPad, pathBounds: pathBounds)
//                .trim(from: 0, to: endAmount)
//
//                .stroke(Color.white, lineWidth: 2)
//                .scaleEffect(scaleReduced ? 0.4 : 1)
//
//            ShapeView(bezier: .roundButton1, pathBounds: pathBounds)
//                .trim(from: 0, to: endAmount)
//
//                .stroke(Color.white, lineWidth: 2)
//                .scaleEffect(scaleReduced ? 0.4 : 1)
//
//            ShapeView(bezier: .roundButton2, pathBounds: pathBounds)
//                .trim(from: 0, to: endAmount)
//
//                .stroke(Color.white,lineWidth: 2)
//                .scaleEffect(scaleReduced ? 0.4 : 1)
//
//            ShapeView(bezier: .roundButton3, pathBounds: pathBounds)
//                .trim(from: 0, to: endAmount)
//
//                .stroke(Color.white,lineWidth: 2)
//                .scaleEffect(scaleReduced ? 0.4 : 1)
//
//            ShapeView(bezier: .roundButton4, pathBounds: pathBounds)
//                .trim(from: 0, to: endAmount)
//
//                .stroke(Color.white, lineWidth: 2)
//                .scaleEffect(scaleReduced ? 0.4 : 1)
//            }
//            Group{
//            ShapeView(bezier: .gLogoFill, pathBounds: pathBounds)
//                .fill((Color(.white)).opacity(isFilled ? 1.00 : 0.00))
//                .scaleEffect(scaleReduced ? 0.4 : 1)
//            ShapeView(bezier: .dPad, pathBounds: pathBounds)
//                .fill((Color(.white)).opacity(isFilled ? 1.00 : 0.00))
//                .scaleEffect(scaleReduced ? 0.4 : 1)
//            ShapeView(bezier: .roundButton1, pathBounds: pathBounds)
//                .fill((Color(.white)).opacity(isFilled ? 1.00 : 0.00))
//                .scaleEffect(scaleReduced ? 0.4 : 1)
//            ShapeView(bezier: .roundButton3, pathBounds: pathBounds)
//                .fill((Color(.white)).opacity(isFilled ? 1.00 : 0.00))
//                .scaleEffect(scaleReduced ? 0.4 : 1)
//                ShapeView(bezier: .roundButton2, pathBounds: pathBounds)
//                    .fill((Color(.white)).opacity(isFilled ? 1.00 : 0.00))
//                    .scaleEffect(scaleReduced ? 0.4 : 1)
//                ShapeView(bezier: .roundButton4, pathBounds: pathBounds)
//                    .fill((Color(.white)).opacity(isFilled ? 1.00 : 0.00))
//                    .scaleEffect(scaleReduced ? 0.4 : 1)
//            }
//
//
//        }.frame(width: 300, height: 300 * pathBounds.height/pathBounds.width)
//                .onAppear {
//                    withAnimation(.easeInOut(duration: 4.5)) {
//                        self.endAmount = 1
//                    }
//                    withAnimation(Animation.easeInOut(duration: 2.5).delay(4.5)) {
//                        self.isFilled = true
//                    }
//                    withAnimation(Animation.easeInOut(duration: 2.5).delay(7.0)) {
//
//                        self.scaleReduced = true
//
//                    }
//
//
//                }
//
//            TypeView()
//
//            }
//                VCSwiftUIView(storyboard: "Main", VC: "initial")
//
//                .opacity(scaleReduced ? 1 : 0)
////                .animation(Animation.easeOut(duration: 2.0).delay(14))
//                .ignoresSafeArea()
//                .animation(Animation.easeOut(duration: 2.0).delay(14), value: scaleReduced)
//
//        }
//
//
//        }
//
//
//        )
//
//
//    }
//}
//
//
//struct TypeView : View {
//        @State var typeOpacity : Double = 0
//        @State var typeOffset : CGFloat = 75.0
//        let screenSize = UIScreen()
//        let typeBounds = UIBezierPath.calculateBounds(paths: [.gFont,.aFont,.mFont,.eFont,.oFont, .lFont, .oFont2, .gFont2, .yFont])
//
//
//        var body : some View {
//            ZStack {
//
//            HStack(alignment: .center){
//                                    Group{
//                                    ShapeView(bezier: .gFont, pathBounds: typeBounds)
//                                            .fill(Color.white)
//                                    ShapeView(bezier: .aFont, pathBounds: typeBounds)
//                                            .fill(Color.white)
//                                    ShapeView(bezier: .mFont, pathBounds: typeBounds)
//                                            .fill(Color.white)
//                                    ShapeView(bezier: .eFont, pathBounds: typeBounds)
//                                            .fill(Color.white)
//                                    ShapeView(bezier: .oFont, pathBounds: typeBounds)
//                                            .fill(Color.white)
//                                    ShapeView(bezier: .lFont, pathBounds: typeBounds)
//                                            .fill(Color.white)
//                                    ShapeView(bezier: .oFont2, pathBounds: typeBounds)
//                                            .fill(Color.white)
//                                    ShapeView(bezier: .gFont2, pathBounds: typeBounds)
//                                            .fill(Color.white)
//                                    ShapeView(bezier: .yFont, pathBounds: typeBounds)
//                                            .fill(Color.white)
//                                    }
//        }
//
//        .frame(width: 140, height: 85)
//        .alignmentGuide(SwiftUI.HorizontalAlignment.center , computeValue: {d in 100})
//        .offset(x: 0, y: typeOffset)
//        .opacity(typeOpacity)
//        .onAppear {
//
//            withAnimation(Animation.easeInOut(duration: 3).delay(7.75)) {
//                self.typeOpacity = 1
//                self.typeOffset = 10
////                self.animationComplete = true
//            }
//        }
//
//
//
//            }
//
//
//
//
//
//
//    }
//
//
//
//    }
//
//
//struct AnimatedBackground : View {
//
//@State var start = UnitPoint(x: 0, y: -2)
//@State var end = UnitPoint(x: 4, y: 0)
//
//let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
//    let colors = [Color.blue, Color(UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(UIColor.systemIndigo)]
//
//var body: some View {
//
//    LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
////        .animation(Animation.easeInOut(duration: 6).repeatForever())
//        .animation(Animation.easeInOut(duration: 6).repeatForever(), value: start)
//        .onReceive(timer, perform: { _ in
//
//            self.start = UnitPoint(x: 4, y: 0)
//            self.end = UnitPoint(x: 0, y: 2)
//            self.start = UnitPoint(x: -4, y: 20)
//            self.start = UnitPoint(x: 4, y: 0)
//        })
//}
//}
//
//
//
//struct VCSwiftUIView: UIViewControllerRepresentable {
//
//    let storyboard: String
//    let VC: String
//
//  func makeUIViewController(context: UIViewControllerRepresentableContext<VCSwiftUIView>) -> OnboardInitialVC {
//
//    //Load the storyboard
//    let loadedStoryboard = UIStoryboard(name: storyboard, bundle: nil)
//    //Load the ViewController
//     return loadedStoryboard.instantiateViewController(withIdentifier: "initial") as! OnboardInitialVC
//  }
//
//  func updateUIViewController(_ uiViewController: OnboardInitialVC, context: UIViewControllerRepresentableContext<VCSwiftUIView>) {
//  }
//}
//
//struct ContentView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ContentView()
////            .previewInterfaceOrientation(.portrait)
////        .previewInterfaceOrientation(.portrait)
//    }
//
//}
//
