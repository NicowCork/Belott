//
//  SettingsMainView.swift
//  Belott
//
//  Created by Nicolas Richard on 16/01/2022.
//

import SwiftUI

struct ExDivider: View {
    let width: CGFloat
    var body: some View {
        Rectangle()
            .foregroundColor(Colors.divider_color)
            .frame(width: width,height: 0.5)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct SettingsMainView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @State var theme_changed: VisualTheme = .ocean
    
    
    var body: some View {
//        ZStack {
//            Colors.background_settings
//                .edgesIgnoringSafeArea(.top)
//                .ignoresSafeArea()
//                .clipShape(BackGroundSettingsMenuShape())
//            BackGroundSettingsMenuShape()
//                .stroke(style: StrokeStyle(lineWidth: 1, lineCap: CGLineCap.round, lineJoin: CGLineJoin.round, dash: [10, 10]))
            
            VStack(alignment: .leading, spacing: 6) {
//                VStack(alignment: .leading){
//                    Text(" \(Image(systemName: "gear")) Réglages").font(.title)
//                    Divider()
//                }
                VStack(alignment: .leading){
                    HStack(spacing: 60) {
                        Text("Thème visuel sélectionné: \(userSettings.colors_theme == "theme_ocean" ? "Ocean" : "Nature" )").font(.subheadline)
                        HStack{
                            ZStack {
                            
                                Button {
                                    if theme_changed == .ocean {
                                        theme_changed = .nature
                                        userSettings.colors_theme = "theme_ocean"
                                    } else if theme_changed == .nature {
                                        theme_changed = .ocean
                                        userSettings.colors_theme = "theme_ocean"
                                    }
                                    
                                } label: {
                                    Image(systemName: "drop.fill").foregroundColor(.blue).frame(width: 25, height: 25)
                                }
                                Rectangle()
                                    .stroke(lineWidth: userSettings.colors_theme == "theme_ocean" ? 3 : 1)
                                    .frame(width: 25, height: 25)
                            }
//                            .border(theme_changed ? .black : .white)
                            
                            
                            ZStack {
                                
                                Button {
                                    if theme_changed == .nature {
                                        theme_changed = .ocean
                                        userSettings.colors_theme = "theme_nature"
                                    } else if theme_changed == .ocean {
                                        theme_changed = .nature
                                        userSettings.colors_theme = "theme_nature"
                                    }
                                } label: {
                                    Image(systemName: "leaf.fill").foregroundColor(.green).frame(width: 25, height: 25)
                                }
                                Rectangle()
                                    .stroke(lineWidth: userSettings.colors_theme == "theme_nature" ? 3 : 1)
                                    .frame(width: 25, height: 25)
                            }
//                            .border(theme_changed ? .white : .black)
                            
                        }
                        
                    }
                    Toggle(isOn: $userSettings.sonActiver) {
                        Text("Activer les éffets sonores ?").font(.subheadline)
                    }
                    Toggle(isOn: $userSettings.autolockDisabled) {
                        Text("Empêcher la mise en veille de l'écran ?").font(.subheadline)
                    }
                    .onTapGesture {
                        // debuging
                        print(UIApplication.shared.isIdleTimerDisabled.description)
                    }
                    Text("Lien officiel Wikipédia des règles de la Belote.")
                        .font(.subheadline)
                        .underline()
                        .foregroundColor(Color.blue)
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: "https://fr.wikipedia.org/wiki/Belote")!)
                        }
                }
                Spacer().frame(height: 12)
                VStack(alignment: .leading) {
                    Text("  Règles de la Belote").font(.title2)
                    ExDivider(width: 310)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Partie en ...")
                        Text("Nombres de manches gagnantes ...")
                        Text("La belote fait chuter ...")
                        Text("Sens de la distribution ...")
                    }
                    .font(.subheadline)
                    ExDivider(width: 280)
                }
                Spacer().frame(height: 12)
                VStack(alignment: .leading)  {
                    Text("  Règles de la Coinche").font(.title2)
                    ExDivider(width: 280)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Partie en ...")
                        Text("Nombres de manches gagnantes ...")
                        Text("La belote fait chuter ...")
                        Text("Sens de la distribution ...")
                    }
                    .font(.subheadline)
                }
                Spacer()
                
            }
            
            .padding()
        }
//    }
}



struct BackGroundSettingsMenuShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.6 , y: rect.maxY))
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.2),
                      control1: CGPoint(x: rect.maxX, y: rect.maxY),
                      control2: CGPoint(x: rect.maxX * 0.75, y: rect.maxY * 0.75))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: .zero)
        
        return path
    }
}

struct SettingsMainView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsMainView()
    }
}
