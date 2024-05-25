//
//  CardView.swift
//  Belott
//
//  Created by Nicolas Richard on 14/01/2022.
//

import SwiftUI

struct CardView: View {
    
    @State var suit: CardSuit
    @State var rank: CardRank
    @State var sizeTopBot: CGFloat
    @State var sizeMiddle: CGFloat
    
    var body: some View {
        ZStack {
//            Colors.jaunemoche
            
            RoundedRectangle(cornerRadius: 15, style: RoundedCornerStyle.circular).stroke(lineWidth: 5)
            
            VStack(spacing: 60) {
                
                HStack {
                    RankPlusSuit(suit: suit, rank: rank, size: sizeTopBot)
                    Spacer()
                }
                Spacer()
                
                OnlySuit(suit: suit, size: sizeMiddle)
                
                Spacer()
                
                HStack {
                    Spacer()
                    RankPlusSuit(suit: suit, rank: rank, size: sizeTopBot).rotationEffect(Angle(degrees: 180))
                }

            }
            
            .padding()
        }
    }
    
    struct RankPlusSuit: View {
        @State var suit: CardSuit
        @State var rank: CardRank
        @State var size: CGFloat
        var body: some View {
            VStack {
                Text(rank.rawValue)
                Text(suit.rawValue)
            }
            .font(.system(size: size))
        }
    }
    struct OnlySuit: View {
        @State var suit: CardSuit
        @State var size: CGFloat
        
        var body: some View {
            VStack {
                Text(suit.rawValue)
            }
            .font(.system(size: size))
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(suit: .hearts  , rank: .ace, sizeTopBot: 40, sizeMiddle: 70)
    }
}
