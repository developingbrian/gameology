//
//  SplashView.swift
//  collector
//
//  Created by Brian on 12/11/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    
    let network = Networking.shared
    
    @State var animationComplete = false
    @State var endAmount : CGFloat = 0
    @State var scaleReduced = false
    @State var isFilled = false
    @State var dataFetched = false
    @State var fadeOut = false
    
    @State var redAmount : CGFloat = 0
    @State var blueAmount : CGFloat = 0
    @State var greenAmount : CGFloat = 0
    @State var yellowAmount : CGFloat = 0
    @State var orangeAmount : CGFloat = 0
    
    let pathBounds = UIBezierPath.calculateBounds(paths: [.gLogoShape, .gLogoFill, .dPad, .roundButton1, .roundButton2, .roundButton3, .roundButton4])
    
    var body: some View {
        
        ZStack {
            
            let defaults = UserDefaults.standard
            let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
            
            Color(appearanceSelection == 2 ? "color7" : "color6").ignoresSafeArea()
            
            
            RadialGradient(colors: [Color("color4"), Color("color5")], center: .center, startRadius: 0, endRadius: 400).offset(x: 0, y: -50).padding(-50).ignoresSafeArea().overlay(
                ZStack(alignment: SwiftUI.Alignment(horizontal: .center, vertical: .bottom)) {
                    
                    
                    ZStack{
                        
                        Group {
                            //Logo Shape
                            
                            ShapeView(bezier: .gLogoFill, pathBounds: pathBounds)
                                .trim(from: 0, to: greenAmount)
                            
                                .stroke(Color.purple, lineWidth: 6)
                                .opacity(dataFetched ? 0 : 1)
                            
                            ShapeView(bezier: .gLogoFill, pathBounds: pathBounds)
                                .trim(from: 0, to: redAmount)
                                .stroke(Color.red, lineWidth: 6)
                                .opacity(dataFetched ? 0 : 1)
                            
                            ShapeView(bezier: .gLogoFill, pathBounds: pathBounds)
                                .trim(from: 0, to: blueAmount)
                            
                                .stroke(Color.blue, lineWidth: 6)
                                .opacity(dataFetched ? 0 : 1)
                            
                            
                            ShapeView(bezier: .gLogoFill, pathBounds: pathBounds)
                                .trim(from: 0, to: endAmount)
                                .stroke(Color.white, lineWidth: 2)
                                .opacity(dataFetched ? 0 : 1)
                            
                            
                            
                            Group {
                                //DPAD Shape
                                
                                ShapeView(bezier: .dPad, pathBounds: pathBounds)
                                    .trim(from: 0, to: greenAmount)
                                    .stroke(Color.green, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .dPad, pathBounds: pathBounds)
                                    .trim(from: 0, to: redAmount)
                                    .stroke(Color.red, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                
                                ShapeView(bezier: .dPad, pathBounds: pathBounds)
                                    .trim(from: 0, to: blueAmount)
                                    .stroke(Color.blue, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                
                                ShapeView(bezier: .dPad, pathBounds: pathBounds)
                                    .trim(from: 0, to: endAmount)
                                    .stroke(Color.white, lineWidth: 2)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                
                            }
                            
                            Group {
                                
                                //                    Button 1
                                
                                ShapeView(bezier: .roundButton1, pathBounds: pathBounds)
                                    .trim(from: 0, to: greenAmount)
                                    .stroke(Color.green, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton1, pathBounds: pathBounds)
                                    .trim(from: 0, to: redAmount)
                                    .stroke(Color.red, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton1, pathBounds: pathBounds)
                                    .trim(from: 0, to: blueAmount)
                                    .stroke(Color.blue, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton1, pathBounds: pathBounds)
                                    .trim(from: 0, to: endAmount)
                                    .stroke(Color.white, lineWidth: 2)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                
                            }
                            
                            Group {
                                //Button 2
                                ShapeView(bezier: .roundButton2, pathBounds: pathBounds)
                                    .trim(from: 0, to: greenAmount)
                                    .stroke(Color.green, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton2, pathBounds: pathBounds)
                                    .trim(from: 0, to: redAmount)
                                    .stroke(Color.red, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton2, pathBounds: pathBounds)
                                    .trim(from: 0, to: blueAmount)
                                    .stroke(Color.blue, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton2, pathBounds: pathBounds)
                                    .trim(from: 0, to: endAmount)
                                    .stroke(Color.white, lineWidth: 2)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                
                            }
                            
                            Group {
                                //Button 3
                                ShapeView(bezier: .roundButton3, pathBounds: pathBounds)
                                    .trim(from: 0, to: greenAmount)
                                    .stroke(Color.green, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton3, pathBounds: pathBounds)
                                    .trim(from: 0, to: redAmount)
                                    .stroke(Color.red, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton3, pathBounds: pathBounds)
                                    .trim(from: 0, to: blueAmount)
                                    .stroke(Color.blue, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton3, pathBounds: pathBounds)
                                    .trim(from: 0, to: endAmount)
                                    .stroke(Color.white, lineWidth: 2)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                
                            }
                            
                            Group {
                                //Button 4
                                
                                ShapeView(bezier: .roundButton4, pathBounds: pathBounds)
                                    .trim(from: 0, to: greenAmount)
                                    .stroke(Color.green, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton4, pathBounds: pathBounds)
                                    .trim(from: 0, to: redAmount)
                                    .stroke(Color.red, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton4, pathBounds: pathBounds)
                                    .trim(from: 0, to: blueAmount)
                                    .stroke(Color.blue, lineWidth: 6)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                ShapeView(bezier: .roundButton4, pathBounds: pathBounds)
                                    .trim(from: 0, to: endAmount)
                                    .stroke(Color.white, lineWidth: 2)
                                    .opacity(dataFetched ? 0 : 1)
                                
                                
                            }
                            
                            
                            
                        }
                        
                        Group{
                            //Scaled Views
                            
                            
                            ShapeView(bezier: .gLogoFill, pathBounds: pathBounds)
                                .fill((Color(.white)).opacity(dataFetched ? 1.00 : 0.00))
                                .scaleEffect(isFilled ? 10 : 1)
                            
                            
                            ShapeView(bezier: .dPad, pathBounds: pathBounds)
                                .fill((Color(.white)).opacity(dataFetched ? 1.00 : 0.00))
                                .scaleEffect(isFilled ? 10 : 1)
                            
                            ShapeView(bezier: .roundButton1, pathBounds: pathBounds)
                                .fill((Color(.white)).opacity(dataFetched ? 1.00 : 0.00))
                                .scaleEffect(isFilled ? 10 : 1)
                            
                            ShapeView(bezier: .roundButton3, pathBounds: pathBounds)
                                .fill((Color(.white)).opacity(dataFetched ? 1.00 : 0.00))
                                .scaleEffect(isFilled ? 10 : 1)
                            
                            ShapeView(bezier: .roundButton2, pathBounds: pathBounds)
                                .fill((Color(.white)).opacity(dataFetched ? 1.00 : 0.00))
                                .scaleEffect(isFilled ? 10 : 1)
                            
                            ShapeView(bezier: .roundButton4, pathBounds: pathBounds)
                                .fill((Color(.white)).opacity(dataFetched ? 1.00 : 0.00))
                                .scaleEffect(isFilled ? 10 : 1)
                        }
                        
                        
                        
                    }.frame(width: 100, height: 100 * pathBounds.height/pathBounds.width)
                        .onAppear {
                            
                            withAnimation(.easeInOut(duration: 2.5).delay(0.55).repeatForever(autoreverses: true)) {
                                greenAmount = 1
                                
                            }
                            withAnimation(.easeInOut(duration: 2.5).delay(0.4).repeatForever(autoreverses: true)) {
                                
                                redAmount = 1
                            }
                            withAnimation(.easeInOut(duration: 2.5).delay(0.25).repeatForever(autoreverses: true)) {
                                
                                blueAmount = 1
                            }
                            withAnimation(.easeInOut(duration: 2.5).delay(0.05).repeatForever(autoreverses: true)) {
                                
                                orangeAmount = 1
                            }
                            
                            withAnimation(.easeInOut(duration: 2.5)) {
                                self.endAmount = 1
                            }
                            
                            
                        }
                    
                    
                    
                })
                .onAppear {
                    
                    prepareData {
                        withAnimation(.easeInOut(duration: 1)) {
                            dataFetched = true
                        }
                        
                        withAnimation(.easeOut(duration: 0.5).delay(2)) {
                            isFilled = true
                            
                        }
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                            
                            withAnimation(.linear) {
                                fadeOut = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                                
                                DispatchQueue.main.async {
                                    
                                    
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "push"), object: nil)
                                }
                                
                            }
                        }
                        
                        
                        
                    }
                    
                    
                    
                }
            
                .opacity(fadeOut ? 0 : 1)
            
            
        }
        
    }
    
    
}



func prepareData(onComplete: @escaping () -> () ) {
    let platformIDs = [48, 49, 130, 167, 169]
    
    guard let randomPlatformIDComingSoon = platformIDs.randomElement() else { return }
    
    network.fetchIGDBComingSoonData(platformID: randomPlatformIDComingSoon) { error in
        
        if error == nil {
            guard let randomPlatformIDRecentlyReleased = platformIDs.randomElement() else { return }
            
            
            network.fetchIGDBRecentlyReleasedData(platformID: randomPlatformIDRecentlyReleased) { error in
                if error == nil {
                    
                    guard let randomPlatformIDTop20 = platformIDs.randomElement() else { return }
                    
                    
                    network.fetchIGDBTop20Data(platformID: randomPlatformIDTop20) { error in
                        
                        
                        if error == nil {
                            
                            network.fetchIGDBGenreData { error in
                                if error == nil {
                                    
                                    
                                    network.fetchIGDBPlatformData { error in
                                        
                                        if error == nil {
                                            
                                            var lastFetchedPlatform = UserDefaults.standard.value(forKey: "lastFetchedPlatform") as? Int
                                            
                                            if lastFetchedPlatform == nil {
                                                UserDefaults.standard.setValue(18, forKey: "lastFetchedPlatform")
                                                lastFetchedPlatform = 18
                                            }
                                            guard let lastPlatform = lastFetchedPlatform else { return }
                                            network.lastRequestedPlatformID = lastPlatform
                                            
                                            network.fetchIGDBGamesData(filterBy: "platforms = ", platformID: network.lastRequestedPlatformID, searchByName: nil, sortByField: "name", sortAscending: true, offset: network.currentOffset, resultsPerPage: 500) { error in
                                                
                                                if error == nil {
                                                    
                                                    if network.initialFetchComplete == true {
                                                        network.currentOffset += 500
                                                        
                                                        DispatchQueue.main.async {
                                                            onComplete()
                                                            
                                                        }
                                                        
                                                        
                                                        
                                                        
                                                    }
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                }
                                                
                                                
                                                
                                                
                                                
                                            }
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                            }
                            
                        }
                        
                    }
                    
                    
                }
            }
            
        }
        
        
        
    }
    
    
    
}







struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
    
    
}
