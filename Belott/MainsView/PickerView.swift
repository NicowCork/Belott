//
//  NewGameMenu.swift
//  Belott
//
//  Created by Nicolas Richard on 13/01/2022.
//

import SwiftUI

struct PickerRandomButton: ViewModifier {
    
    let widthAndHeight: CGFloat = 50
    
    func body(content: Content) -> some View {
        VStack {
            content.foregroundColor(Colors.button_plus)
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .shadow(radius: 4)
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(Colors.button_plus)
                //                        .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
            }
            
        }
    }
}



// only belote for now
struct PickerView: View {
    
    let widthAndHeight: CGFloat
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var isStarterViewShowed: Bool = false
    @State var isConfirmationViewShowed: Bool = false
    @State var isGameChoiceViewShowed: Bool = true
    
    @State var game = Game()
    
    //    @State var gamePlayed: Game.GamesPlayed = .Belote
    //
    //    @State var isNordSelected: Bool = true
    //    @State var isOuestSelected: Bool = true
    //    @State var isSudSelected: Bool = true
    //    @State var isEstdSelected: Bool = true
    
    // BUTTTON NORD POUR TEST
    
    var body: some View {
        //        ZStack {
        //            Colors.background_picker
        //                .clipShape(BackGroundPickerMenuShape())
        //            BackGroundPickerMenuShape()
        //                .stroke(style: StrokeStyle(lineWidth: 1, lineCap: CGLineCap.round, lineJoin: CGLineJoin.round, dash: [10, 10]))
        
        VStack(spacing: 30) {
            // Norrd Sud Est Ouest
            Spacer()
            
            VStack(alignment: .center, spacing: 0) {
                Text("Le joueur situé au Nord commence à distribuer ?").foregroundColor(Colors.button_plus).bold()
                Spacer().frame(height: 50)
                HStack(spacing: 50) {
                    ZStack {
                        //                            Circle()
                        //                                .foregroundColor(.white)
                        //                                .frame(width: widthAndHeight + 0, height: widthAndHeight + 0)
                        //                                .shadow(radius: 4)
                        Image(systemName: "xmark.shield")
                            .resizable()
                            .frame(width: widthAndHeight + 0, height: widthAndHeight + 0)
                            .foregroundColor(Colors.button_plus)
                        //                        .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                    }
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.55)){
                            viewRouter.currentView = .game
                        }
                    }
                    ZStack {
                        //                            Circle()
                        //                                .foregroundColor(.white)
                        //                                .frame(width: widthAndHeight + 5, height: widthAndHeight + 5)
                        //                                .shadow(radius: 4)
                        Image(systemName: "checkmark.shield")
                            .resizable()
                            .frame(width: widthAndHeight + 5, height: widthAndHeight + 5)
                            .foregroundColor(Colors.button_plus)
                        //                        .rotationEffect(Angle(degrees: showPopUp ? 90 : 0))
                    }
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.55)){
                            viewRouter.currentView = .game
                        }
                    }
                }
            }
            .opacity(isConfirmationViewShowed ? 1 : 0.3)
            .blur(radius: isConfirmationViewShowed ? 0 : 2)
            .transition(.opacity)
            
            
            
            
            VStack(alignment: .center, spacing: 10) {
                Text("Qui commmence ? ").foregroundColor(Colors.button_plus).bold()
                
                Text("Nord").bold().modifier(SelectionningButtonModifier(isSelected: game.dealer == .Nord ? true : false))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.35)) {
                            if isConfirmationViewShowed == true && isGameChoiceViewShowed == false {
                                isConfirmationViewShowed = false
                                isStarterViewShowed = true
                            } else {
                                game.dealer = .Nord
                                isConfirmationViewShowed = true
                            }
                        }
                    }
                
                HStack(spacing: 10) {
                    Text("Est").bold().modifier(SelectionningButtonModifier(isSelected: game.dealer == . Est ? true : false))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.35)) {
                                if isConfirmationViewShowed == true && isGameChoiceViewShowed == false {
                                    isConfirmationViewShowed = false
                                    isStarterViewShowed = true
                                } else {
                                    game.dealer = .Est
                                    isConfirmationViewShowed = true
                                }
                            }
                        }
                    Text("Au hasard !").bold().modifier(PickerRandomButton())
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.35)) {
                                if isConfirmationViewShowed == true && isGameChoiceViewShowed == false {
                                    isConfirmationViewShowed = false
                                    isStarterViewShowed = true
                                } else {
                                    game.dealer = .Nord
                                    isConfirmationViewShowed = true
                                }
                            }
                        }
                    Text("Ouest").bold().modifier(SelectionningButtonModifier(isSelected: game.dealer == . Ouest ? true : false))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.35)) {
                                if isConfirmationViewShowed == true && isGameChoiceViewShowed == false {
                                    isConfirmationViewShowed = false
                                    isStarterViewShowed = true
                                } else {
                                    game.dealer = .Ouest
                                    isConfirmationViewShowed = true
                                }
                            }
                        }
                }
                
                Text("Toi").bold().modifier(SelectionningButtonModifier(isSelected: game.dealer == .Sud ? true : false))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.35)) {
                            if isConfirmationViewShowed == true && isGameChoiceViewShowed == false {
                                isConfirmationViewShowed = false
                                isStarterViewShowed = true
                            } else {
                                game.dealer = .Sud
                                isConfirmationViewShowed = true
                            }
                        }
                    }
                
            }
            .opacity(isStarterViewShowed ? 1 : 0.3)
            .blur(radius: isStarterViewShowed ? 0 : 2)
            .transition(.opacity)
            
            
            
            // Belote + Coinche
            HStack(spacing: 50) {
                Text("Belote").bold().modifier(SelectionningButtonModifier(isSelected: game.gamePlayed == .Belote ? true : false))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.35)) {
                            if isStarterViewShowed == true && isConfirmationViewShowed == true {
                                isConfirmationViewShowed = false
                                isStarterViewShowed = false
                                isGameChoiceViewShowed = true
                                game.gamePlayed = .None
                            } else if isStarterViewShowed ==  true || isConfirmationViewShowed == true {
                                isStarterViewShowed = false
                                isGameChoiceViewShowed = true
                                game.gamePlayed = .None
                            } else {
                                game.gamePlayed = .Belote
                                isGameChoiceViewShowed = false
                                isStarterViewShowed = true
                            }
                            
                        }
                    }
                
                Text("Coinche").bold().modifier(SelectionningButtonModifier(isSelected: game.gamePlayed == .Coinche ? true : false))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.35)) {
                            withAnimation(.easeIn(duration: 0.35)) {
                                if isStarterViewShowed == true && isConfirmationViewShowed == true {
                                    isConfirmationViewShowed = false
                                    isStarterViewShowed = false
                                    isGameChoiceViewShowed = true
                                    game.gamePlayed = .None
                                } else if isStarterViewShowed ==  true || isConfirmationViewShowed == true {
                                    isStarterViewShowed = false
                                    isGameChoiceViewShowed = true
                                    game.gamePlayed = .None
                                } else {
                                    game.gamePlayed = .Coinche
                                    isGameChoiceViewShowed = false
                                    isStarterViewShowed = true
                                }
                                
                            }
                        }
                    }
                
            }
            .blur(radius: isGameChoiceViewShowed ? 0 : 2)
            .transition(.opacity)
        }
        
        
        
    }
    
    //    }
}
struct BackGroundPickerMenuShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX * 0.8, y: rect.maxY * 0.5),
                      control2: CGPoint(x: rect.maxX, y: rect.maxY)) //curve
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.minY),
                      control1: CGPoint(x: rect.maxX * 0.2, y: rect.maxY * 0.5),
                      control2: CGPoint(x: rect.minX, y: rect.minY))
        
        return path
    }
}
struct NewGameMenu_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(widthAndHeight: 20).environmentObject(ViewRouter())
    }
}


