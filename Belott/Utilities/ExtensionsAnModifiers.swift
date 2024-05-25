//
//  ExtensionsAnModifiers.swift
//  Belott
//
//  Created by Nicolas Richard on 03/02/2022.
//

import Foundation
import SwiftUI

struct GrowingButton: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .foregroundColor(color)
            
    }
}

struct ModifierMaxPointsMenu: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(lineWidth: 2)
                .background(Colors.background_namesview.cornerRadius(10))
                .frame(width: UIScreen.main.bounds.width / 4.5, height: 40)
            
            content
                .font(.headline)
            
            
        }
    }
}

struct SelectionningButtonModifier: ViewModifier {
    
    let width: CGFloat = 75
    let height: CGFloat = 40
    
    var isSelected: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(lineWidth: 2)
                .background(isSelected ? Colors.background_namesview.cornerRadius(10) : Colors.button_plus.cornerRadius(10))
                .frame(width: width + 15, height: height + 5)
            content
                .frame(width: width, height: height)
                .foregroundColor(.black)
        }
        
    }
}

struct TopMenuButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(lineWidth: 2)
                .frame(width: 60, height: 50)
                .background(LinearGradient(colors: [Color.black, Color.purple, Color.blue], startPoint: .top, endPoint: .bottom))
            
            content
                .foregroundColor(.black)
        }
        
    }
}


struct TextMenuModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(lineWidth: 2)
                .background(Colors.background_namesview.cornerRadius(10))
                .frame(width: 320, height: 80)
            
            content
                .foregroundColor(.black)
        }
        
    }
}
//
struct ModifierActualAndPreviousRounds: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(lineWidth: 2)
                .background(Colors.background_namesview.cornerRadius(10))
                .frame(width: UIScreen.main.bounds.width / 2.5, height: 40)
            
            content
                .font(.headline)
        }
    }
}
struct ModifierNameScoreView: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(lineWidth: 2)
                .background(Color.clear)
                .frame(width: UIScreen.main.bounds.width / 4.7, height: 50)
            
            content
                .font(.headline)
        }
    }
}

struct ModifierTopMessage: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(lineWidth: 2)
                .background(Colors.background_namesview.cornerRadius(10))
                .frame(width: UIScreen.main.bounds.width / 2.2, height: 40)
            
            content
                .font(.headline)
        }
    }
}
struct TextMenuModifierSmall: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(lineWidth: 2)
                .background(Colors.background_namesview.cornerRadius(10))
                .frame(width: 160, height: 50)
            
            content
                .foregroundColor(.black)
        }
        
    }
}
