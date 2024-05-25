//
//  TabBarIcon.swift
//  Belott
//
//  Created by Nicolas Richard on 13/01/2022.
//

import SwiftUI

struct TabBarIcon: View {
    let width, height: CGFloat
    let systemIconName, tabName: String
    
//    @StateObject var viewRouter: ViewRouter
//    let assignedPage: Page
    @State private var rotation = 0.0
    
    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
//                .rotationEffect(.degrees(rotation))
            Text(tabName)
                .bold()
            Spacer()
        }
//        .onTapGesture {
//            withAnimation {
//                rotation = 280
//            }
//        }
    }
}

struct TabBarIcon_Previews: PreviewProvider {
    static var previews: some View {
        TabBarIcon(width: 100, height: 30, systemIconName: "homekit", tabName: "Home")
        
    }
}
