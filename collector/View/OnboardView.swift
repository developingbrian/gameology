//
//  ContentView.swift
//  onboarding
//
//  Created by Brian on 12/2/21.
//

import SwiftUI

struct OnboardView: View {
    @AppStorage("currentPage") var currentPage = 1
    var onboardComplete = false
    let presentController = "notificationPresent"
    
    @State var showApp = false
    @State var readyToPushController = false
    
    
    var body: some View {
        if currentPage > totalPages {
            ZStack{
                AnimatedBackground().edgesIgnoringSafeArea(.all)
                    .overlay(
                        ZStack{
                            Home()
                                .transition(.opacity)
                            
                                .onAppear {
                                    if showApp == true {
                                        showApp = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                                        showApp = true
                                        
                                        if showApp == true {
                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "push"), object: nil)
                                        }
                                        
                                    })
                                    
                                }
                            
                        }
                    )
                
            }
        } else {
            WalkthroughScreen()
        }
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView()
    }
}


struct Home : View {
    @ObservedObject var appSettings = AppSettings.shared
    
    var body : some View {
        
        Text("Welcome to Gameology")
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .shadow(color: .black, radius: 5, x: 3, y: 3)
        
    }
}





struct ScreenView: View {
    var sceneDelegate = SceneDelegate.shared
    var model = ToggleModel.shared
    
    @State var selection = 0
    var image: String
    var title: String
    var detail: String
    var bgColor: String
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var modes : [ColorScheme] = [.light, .dark]
    @AppStorage("currentPage") var currentPage = 1
    @ObservedObject var appSettings = AppSettings.shared
    @ObservedObject var interfaceSetting = InterfaceSetting.shared
    var traitCollection = UITraitCollection()
    
    var body: some View {
        
        let deselectedColor = (interfaceSetting.selection == 1 ? Color.black.opacity(0.4) : Color.white.opacity(0.4))
        let selectedColor = (interfaceSetting.selection == 2 ? Color.white.opacity(1) : deselectedColor)
        
        
        ZStack{
            
            GradientBGView(bgColor: bgColor).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                HStack {
                    
                    if currentPage == 1 {
                        VStack(alignment: .leading) {
                            Text("Welcome to Gameology")
                                .font(.title)
                                .fontWeight(.semibold)
                                .kerning(1.4)
                            
                            Text("Lets take a look around...")
                        }
                        
                    } else {
                        Button(action: {
                            
                            
                            withAnimation(.easeInOut) {
                                currentPage -= 1
                            }
                        }, label: {
                            SwiftUI.Image(systemName: "chevron.left")
                                .foregroundColor(Color.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background(interfaceSetting.selection == 1 ? Color.black.opacity(0.4) : Color.white.opacity(0.4))
                                .cornerRadius(10)
                            
                            
                        })
                        
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        withAnimation(.easeOut) {
                            
                            currentPage = 7
                        }
                        
                    }, label: {
                        
                        Text("Skip")
                            .fontWeight(.semibold)
                            .kerning(1.2)
                            .foregroundColor(interfaceSetting.selection == 1 ? .black : .white)
                        
                    })
                }
                .foregroundColor(interfaceSetting.selection == 1 ? .black : .white)
                .padding()
                
                Spacer(minLength: 0)
                
                SwiftUI.Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(interfaceSetting.selection == 1 ? .black : .white)
                    .padding(.top)
                
                if currentPage == 6 {
                    HStack {
                        
//                        Button(action: {
//                            model.mode = 0
//                            interfaceSetting.selection = 0
//                        }, label: {
//                            Text("Adaptive")
//                                .foregroundColor(interfaceSetting.selection == 0 ? .black : .white)
//
//                                .padding(.vertical, 10)
//                                .padding(.horizontal)
//                        })
//                            .background(Capsule().fill(interfaceSetting.selection == 0 ? selectedColor : deselectedColor))
//
                        
                        
                        
                        Button(action: {
                            interfaceSetting.selection = 1
                            model.mode = 1
                        }, label: {
                            Text("Light")
                            
                                .foregroundColor(interfaceSetting.selection == 1 ? .black : .white)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            
                            
                        })
                            .background(Capsule().fill(interfaceSetting.selection == 1 ? selectedColor : deselectedColor))
                        
                        
                        Button(action: {
                            model.mode = 2
                            interfaceSetting.selection = 2
                            
                        }, label: {
                            Text("Dark")
                                .foregroundColor(interfaceSetting.selection == 2 ? .black : .white)
                            
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                            
                            
                        })
                            .background(Capsule().fill(interfaceSetting.selection == 2 ? selectedColor : deselectedColor))
                        
                    }
                    
                }
                
                Text(detail)
                    .fontWeight(.semibold)
                    .kerning(1.3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(interfaceSetting.selection == 1 ? .black : .white)
                
                
                Spacer(minLength: 120)
                
                
            }
            
        }
        
        
        
    }
    
}

struct WalkthroughScreen: View {
    @AppStorage("currentPage") var currentPage = 1
    @State var darkMode = false
    @State var colorMode : ColorScheme = .light
    @ObservedObject var appSettings = AppSettings.shared
    @ObservedObject var interfaceSetting = InterfaceSetting.shared
    @State var interfaceStyle = SceneDelegate.shared?.window?.traitCollection.userInterfaceStyle
    
    var body: some View {
        ZStack{
            
            if currentPage == 1 {
                ScreenView(image: "onboarding1", title: "Manage Your Collection", detail: "Easily manage your game library.  Add and remove games as your collection grows.  Each game allows you to add personalized details about your copy.", bgColor: "color1")
                    .transition(.scale)
            }
            
            if currentPage == 2 {
                
                ScreenView(image: "onboarding2", title: "Wishlist", detail: "Have a game you wish was in your library?  Add it to your wishlist to keep a reminder of the games you are looking for.", bgColor: "color2")
                    .transition(.scale)
            }
            
            if currentPage == 3 {
                
                ScreenView(image: "onboarding3", title: "Advanced Search", detail: "Know what you game are looking for?  Search easily by name, platform, genre, date or any combination there of.", bgColor: "color3")
                    .transition(.scale)
            }
            
            if currentPage == 4 {
                
                ScreenView(image: "onboarding4", title: "Barcode Scanning", detail: "Quickly and easily add your own games to your library by scannning its barcode.", bgColor: "color4")
                    .transition(.scale)
            }
            
            if currentPage == 5 {
                
                ScreenView(image: "onboarding5", title: "iCloud", detail: "Your game library and wishlist support syncing with iCloud.  Make changes on one device, and it will appear on your other iCloud devices automatically.", bgColor: "color5")
                    .transition(.scale)
            }
            
            if currentPage == 6 {
                
                
                if interfaceSetting.selection == 0{
                    
                    if interfaceStyle == .light {

                        ScreenView(image: "onboarding6", title: "Dark Mode", detail: "Dark mode support is built in.  Set your preferred mode and we'll remember it.", bgColor: "color6")
                            .transition(.scale)
                        
                        
                    } else {

                        ScreenView(image: "onboarding6", title: "Dark Mode", detail: "Dark mode support is built in.  Set your preferred mode and we'll remember it.", bgColor: "color7")
                            .transition(.scale)
                        
                    }
                    
                }
                
                if interfaceSetting.selection == 1 {
                    
                    ScreenView(image: "onboarding6", title: "Dark Mode", detail: "Dark mode support is built in.  Set your preferred mode and we'll remember it.", bgColor: "color6")
                        .transition(.scale)
                                        
                }
                
                if interfaceSetting.selection == 2 {
                    
                    ScreenView(image: "onboarding6", title: "Dark Mode", detail: "Dark mode support is built in.  Set your preferred mode and we'll remember it.", bgColor: "color7")
                        .transition(.scale)
                    
                    
                }
                
            }
            
            
            
        }
        .overlay(
            
            Button(
                action: {
                    withAnimation(.easeInOut) {
                        currentPage += 1
                        DispatchQueue.main.async {
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "present"), object: nil)
                        }
                    }
                    
                },
                label: {
                    
                    if interfaceSetting.selection == 2 {

                        SwiftUI.Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(
                                
                                ZStack{
                                    
                                    
                                    Circle()
                                        .stroke(Color.white.opacity(0.2), lineWidth: 4)
                                    
                                    
                                    
                                    
                                    
                                    Circle()
                                        .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                        .stroke(Color.white,lineWidth: 4)
                                        .rotationEffect(.init(degrees: -90))
                                    
                                }
                                    .padding(-15)
                                
                            )
                    } else {
                        SwiftUI.Image(systemName: "chevron.right")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                            .clipShape(Circle()).shadow(radius: 3)
                        
                            .overlay(
                                
                                ZStack{
                                    
                                    
                                    Circle()
                                        .stroke(Color.black.opacity(0.2), lineWidth: 4)
                                    
                                    
                                    
                                    Circle()
                                        .trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages))
                                        .stroke(Color.black,lineWidth: 4)
                                        .rotationEffect(.init(degrees: -90))
                                    
                                }
                                    .padding(-15)
                                
                            )
                        
                    }
                    
                    
                })
                .padding(.bottom, 20)
            , alignment: .bottom
            
            
        )
        
    }
    
}


struct BGView : View {
    var bgColor : String
    
    var body: some View {
        Color(bgColor)
        
    }
}



struct GradientBGView : View {
    var bgColor : String
    
    
    var body: some View {
        
        RadialGradient(colors: [.white, Color(bgColor)], center: .center, startRadius: 0, endRadius: 400).offset(x: 0, y: -50).padding(-50)
        
        
    }
}

class ToggleModel : ObservableObject {
    let sceneDelegate = SceneDelegate.shared
    let defaults = UserDefaults.standard
    static let shared = ToggleModel()

    var mode = 0 {
        didSet {
            var interface : UIUserInterfaceStyle = .unspecified
            
            switch mode {
            case 0:
                interface = .unspecified
            case 1:
                interface = .light
            case 2:
                interface = .dark
            default:
                interface = .unspecified
            }
            
            sceneDelegate?.window!.overrideUserInterfaceStyle = interface
            if mode == 0 {

                NotificationCenter.default.post(name: Notification.Name(rawValue: "interfaceStyle"), object: nil, userInfo: ["style" : 0])
                defaults.setValue(0, forKey: "appearanceSelection")
            }
            
            if mode == 1 {

                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "interfaceStyle"), object: nil, userInfo: ["style" : 1])
                defaults.setValue(1, forKey: "appearanceSelection")
            }
            
            if mode == 2 {

                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "interfaceStyle"), object: nil, userInfo: ["style" : 2])
                defaults.setValue(2, forKey: "appearanceSelection")
            }
        }
    }
    
    var selection : Int = 0
    
}

struct VCSwiftUIView: UIViewControllerRepresentable {
    
    let storyboard: String
    let VC: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<VCSwiftUIView>) -> UITabBarController {
        
        //Load the storyboard
        let loadedStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        //Load the ViewController
        return loadedStoryboard.instantiateViewController(withIdentifier: "start") as! UITabBarController
    }
    
    func updateUIViewController(_ uiViewController: UITabBarController, context: UIViewControllerRepresentableContext<VCSwiftUIView>) {
    }
}


class AppSettings: ObservableObject {
    
    static let shared = AppSettings()
    @AppStorage("current_theme") var currentTheme = "light"
    
}

class InterfaceSetting: ObservableObject {
    
    static let shared = InterfaceSetting()
    @AppStorage("current_selection") var selection = 1
    
}

var totalPages = 6
