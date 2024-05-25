//
//  StatsMainView.swift
//  Belott
//
//  Created by Nicolas Richard on 16/01/2022.
//

import CoreData
import SwiftUI

struct StatsMainView: View {
    
    @FetchRequest(sortDescriptors: []) var gamessaved: FetchedResults<GameSaved>
    
    
    struct PartieView: View {
        
        let date: String
        
        let nameWinner: String
        let scorens: String
        let scoreoe: String
     

        
        var body: some View {
            VStack(spacing:5) {
                Text(date)
                Divider()
                HStack(spacing: 30) {
                    Text(nameWinner)
                    Text(scoreoe)
                    Text(scorens)
                }
                
//                if toggled {
//                    VStack {
//
//                    }
//                }
                
            }
        }
    }
    
    struct RoundView: View {
        let roundscoreoe: String
        let roundscorens: String
        let isnswin: Bool
        
        
        var body: some View {
            HStack {
                Text(roundscorens)
                    .foregroundColor(isnswin ? Colors.nord_sud : Colors.est_ouest)
                
                Text(roundscoreoe)
                    .foregroundColor(isnswin ? Colors.nord_sud : Colors.est_ouest)
            }
        }
    }
    
    let currentDateTime = Date()
    
    @State var toggled: Bool = false
    
    var body: some View {
//        ZStack {
//            Colors.background_stats
//                .clipShape(BackGroundStatsMenuShape())
//            BackGroundStatsMenuShape()
//                .stroke(style: StrokeStyle(lineWidth: 1, lineCap: CGLineCap.round, lineJoin: CGLineJoin.round, dash: [10, 10]))
            
            VStack(alignment: .trailing, spacing: 20) {

                Spacer().frame(height: 10)
                
                if gamessaved.isEmpty {
                    Text("nothin to show")
                } else {
                    
                    
                    
                    List(gamessaved) { gamess in
                        
                        VStack(spacing: 20) {
                            HStack(spacing: 20) {
                                Text(gamess.date ?? currentDateTime ,style: .date)
                                Text(gamess.date ?? currentDateTime, style: .time)
                                
                                Image(systemName: "plus.magnifyingglass")
                                    .frame(width: 50, height: 50)
                                    .onTapGesture {
                                        print("ah")
                                        toggled.toggle()
                                    }
                                
                            }
                            Divider()
                            HStack(spacing: 50) {
                                Text(gamess.winner ?? "Wops")
                                
                                Text(String(gamess.total_ns))
                                    .bold()
                                Text(String(gamess.total_oo))
                                    .bold()
                            }
                            if toggled {
                                ForEach(Array(gamess.roundssaved as? Set<RoundBelote> ?? []), id: \.self) { round in
                                    RoundView(roundscoreoe: String(round.score_ns), roundscorens: String(round.score_oe), isnswin: round.ns_win)
                                }
                            }
                        }
                        .padding(5)
                    }
                    .onAppear {
                        print("how")
                    }
                }
                
                
            }
        }
//    }
}
struct BackGroundStatsMenuShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.4, y: rect.maxY))
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY * 0.2),
                      control1: CGPoint(x: rect.minX * 0.2, y: rect.maxY * 1),
                      control2: CGPoint(x: rect.maxX * 0.2, y: rect.maxY * 0.8))
        path.addLine(to: .zero)
        
        //        path.move(to: .zero)
        //        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        //        path.addLine(to: CGPoint(x: rect.maxX * 0.6 , y: rect.maxY))
        //        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.2),
        //                      control1: CGPoint(x: rect.maxX * 1, y: rect.maxY * 1),
        //                      control2: CGPoint(x: rect.maxX * 0.75, y: rect.maxY * 0.75))
        //        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        //        path.addLine(to: .zero)
        
        return path
    }
}

struct StatsMainView_Previews: PreviewProvider {
    static var previews: some View {
        StatsMainView()
    }
}
