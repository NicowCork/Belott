//
//  ViewRouter.swift
//  Belott
//
//  Created by Nicolas Richard on 13/01/2022.
//

import Foundation
import SwiftUI


class ViewRouter: ObservableObject {
    @Published var currentView: ViewType = .main
}

enum ViewType {
    case main
    case settings
    case stats
    case game
}

enum VisualTheme: String {
    case ocean = "theme_ocean"
    case nature =  "theme_nature"
}


enum Colors {
//    static let background_circle = Color(#colorLiteral(red: 0.6933404207, green: 0.872882843, blue: 0.6208603978, alpha: 1))
//    static let greenfonce = Color(#colorLiteral(red: 0.02352941176, green: 0.2745098039, blue: 0.2078431373, alpha: 1))
//    static let jaunemoche = Color(#colorLiteral(red: 1, green: 0.9522512555, blue: 0.7870212197, alpha: 1))
//    static let button_plus = Color(#colorLiteral(red: 0.6156862745, green: 0.3607843137, blue: 0.05098039216, alpha: 1))
//    static let orangefoncemoche = Color(#colorLiteral(red: 0.6156862745, green: 0.3607843137, blue: 0.05098039216, alpha: 1))
    static let background_1 = Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    static let background_3 = Color(#colorLiteral(red: 0.6055601941, green: 0.8745098039, blue: 0.8823529412, alpha: 1))
    static let background_2 = Color(#colorLiteral(red: 0.5, green: 0.9333333333, blue: 0.9568627451, alpha: 1))
    static let background_4 = Color(#colorLiteral(red: 0.4116749349, green: 0.6561445379, blue: 0.8745098039, alpha: 1))
    
    static let background_5 = Color(#colorLiteral(red: 0, green: 0.7254901961, blue: 0.6823529412, alpha: 1))
    static let background_6 = Color(#colorLiteral(red: 0.6055601941, green: 0.8745098039, blue: 0.8823529412, alpha: 1))
    static let background_7 = Color(#colorLiteral(red: 0.1960784346, green: 0.8085597032, blue: 0.1019607857, alpha: 1))
    static let background_8 = Color(#colorLiteral(red: 0, green: 0.6235294118, blue: 0.5764705882, alpha: 1))
    static let background_9 = Color(#colorLiteral(red: 0.6055601941, green: 0.8745098039, blue: 0.8823529412, alpha: 1))
    
    static let background_10 = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    static let background_11 = Color(#colorLiteral(red: 0.6055601941, green: 0.8745098039, blue: 0.8823529412, alpha: 1))
    static let background_12 = Color(#colorLiteral(red: 0.6055601941, green: 0.8745098039, blue: 0.8823529412, alpha: 1))
    
    static let theme_ocean = [background_1, background_2, background_3, background_4]
    static let theme_nature = [background_5, background_6, background_7, background_8, background_9]
    static let theme_default = [background_10, background_11, background_12]
    
    static let nord_sud = Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
    static let est_ouest = Color(#colorLiteral(red: 0.8784313725, green: 0.4784313725, blue: 0.3725490196, alpha: 1))
    
    static let background_settings = Color(#colorLiteral(red: 0.6055601941, green: 0.8745098039, blue: 0.8823529412, alpha: 1))
    static let background_stats = Color(#colorLiteral(red: 0.5, green: 0.9333333333, blue: 0.9568627451, alpha: 1))
    static let background_namesview = Color(#colorLiteral(red: 0.9411764706, green: 0.7333333333, blue: 0.3843137255, alpha: 1))
    static let background_picker = Color(#colorLiteral(red: 1, green: 0.9333333333, blue: 0.8666666667, alpha: 1))

    static let icon_coupe = Color(#colorLiteral(red: 0.3215686275, green: 0.3176470588, blue: 0.4549019608, alpha: 1))
    static let icon_distribue = Color(#colorLiteral(red: 0.2039215686, green: 0.5411764706, blue: 0.6549019608, alpha: 1))
    static let icon_commence = Color(#colorLiteral(red: 0.3647058824, green: 0.8274509804, blue: 0.6196078431, alpha: 1))
    static let button_plus = Color(#colorLiteral(red: 0.6156862745, green: 0.3607843137, blue: 0.05098039216, alpha: 1))

    static let divider_color = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    
}

enum CardSuit: String {
    case hearts = "❤️"
    case diamonds = "♦️"
    case spades = "♠️"
    case clubs = "♣️"
}
enum CardRank: String {
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case jack = "J"
    case queen = "Q"
    case king = "K"
    case ace = "A"
}

struct AnimatedBackground: View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var colors_theme: [Color]
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: colors_theme), startPoint: start, endPoint: end)
            .animation(Animation.easeInOut(duration: 4).repeatForever())
            .onReceive(timer, perform: { _ in
                
                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x: -4, y: 20)
                self.start = UnitPoint(x: 4, y: 0)
            })
    }
}
struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}


public extension Int {
    /// returns number of digits in Int number
    var digitCount: Int {
        get {
            return numberOfDigits(in: self)
        }
    }
    /// returns number of useful digits in Int number
    var usefulDigitCount: Int {
        get {
            var count = 0
            for digitOrder in 0..<self.digitCount {
                /// get each order digit from self
                let digit = self % (Int(truncating: pow(10, digitOrder + 1) as NSDecimalNumber))
                / Int(truncating: pow(10, digitOrder) as NSDecimalNumber)
                if isUseful(digit) { count += 1 }
            }
            return count
        }
    }
    // private recursive method for counting digits
    private func numberOfDigits(in number: Int) -> Int {
        if number < 10 && number >= 0 || number > -10 && number < 0 {
            return 1
        } else {
            return 1 + numberOfDigits(in: number/10)
        }
    }
    // returns true if digit is useful in respect to self
    private func isUseful(_ digit: Int) -> Bool {
        return (digit != 0) && (self % digit == 0)
    }
}
