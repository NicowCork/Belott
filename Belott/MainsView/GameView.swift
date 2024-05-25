//
//  TableCircle.swift
//  Belott
//
//  Created by Nicolas Richard on 13/01/2022.
//

import SwiftUI
import CoreData

extension View {
    func animateNamesForEver(using animation: Animation = .easeInOut(duration: 0.7), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        
        let repeated = animation.repeatForever(autoreverses: autoreverses)
        
        
        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}
private extension GameView {
    func startAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
            animationAmount = 0.3
        }
    }
    
    func stopAnimation() {
        withAnimation {
            animationAmount = 0
        }
    }
}

struct GameView: View {
    enum sizekeys {
        static let widthhere: CGFloat = UIScreen.main.bounds.width / 3.4
        static let heighthere: CGFloat = UIScreen.main.bounds.height / 13
    }

    var AnimationEffect1: Animation {
        Animation
            .spring(response: 0.55, dampingFraction: 0.825, blendDuration: 1)
    }

    
    struct RowView: View {
        let donneur: String
        let score_oe, score_ns: Int
        let id: Int
        let isDealer: Bool
        let colorDealer: Color
        var body: some View {
            HStack(alignment: .firstTextBaseline) {
                
                ZStack {
                    Circle()
                        .stroke(Colors.background_namesview, lineWidth: 8)
                        .frame(width: 40, height: 40)
                    Text(String(id))
                        .font(.system(size: 25))
                        .bold()
                }
                .offset(x: 4, y: 2)
                
                
                Spacer().frame(width: 21)
                
                ZStack {
                    if isDealer {
                        Image(systemName: "hand.raised.circle.fill")
                            .foregroundColor(colorDealer)
                            .offset(x: 30, y: -10)
                    }
                    Text("\(donneur)")
                        .modifier(ModifierNameScoreView())
                }
                
                
                Text(String(score_oe))
                    .modifier(ModifierNameScoreView())
                
                
                Text(String(score_ns))
                    .modifier(ModifierNameScoreView())
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 3)
//                    .frame(width: 380)
            )
            .padding(5)
            
            
        }
    }
    
    private struct PlayerViewCalc: View {
        
        let isOuestEst: Bool
            
        let width: CGFloat = 75
        let height: CGFloat = 40
        
        let color: Color
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(lineWidth: 2)
                    .frame(width: 140, height: 45)
                    .background(Colors.background_namesview.cornerRadius(10))
                
                if isOuestEst {
                    Text("Ouest / Est").bold()
                } else {
                    Text("Nord / Sud").bold()
                }
                
                Rectangle()
                    .foregroundColor(color)
                    .cornerRadius(3)
                    .frame(width: 13, height: 45)
                    .offset(x: 55)
                
            }
        }
    }
    
    private struct PlayerView: View {
        
        let isSud: Bool
        
        let position: String
        let isDealer: Bool
        let isCutter: Bool
        
        let width: CGFloat = 75
        let height: CGFloat = 40
        
        let color: Color
        let colorDealer: Color
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(lineWidth: 2)
                    .frame(width: 90, height: 45)
                    .background(Colors.background_namesview.cornerRadius(10))
                
                if isSud {
                    VStack(spacing: 0) {
                        Text(position).bold()
                        Text("(Toi)").font(.caption)
                    }
                } else {
                    Text(position).bold()
                }
                
                Rectangle()
                    .foregroundColor(color)
                    .cornerRadius(3)
                    .frame(width: 13, height: 45)
                    .offset(x: 32)
                
                if isDealer {
                    Image(systemName: "hand.raised.circle.fill")
                        .foregroundColor(colorDealer)
                        .offset(x: -30, y: -10)
                }
                
                if isCutter {
                    Image(systemName: "scissors")
                        .rotationEffect(.degrees(280))
                        .foregroundColor(.blue)
                        .offset(x: -30, y: -10)
                }
                
            }
        }
    }
    
    enum CasesSelections {
        case Default
        case Nord
        case Est
        case Sud
        case Ouest
    }
    
    //MARK: button -> desactive siokttape (: si on a commeence une gaame) et tant quon et ssur la vue calc et que isScoreOK false
    func isNouvelleDonneDisabled() -> Bool {
        if !isOkTapMade {
            return true
        } else if isOkTapMade && showCalc && !calcModel.isScoreOK {
            return true
        } else {
            return false
        }
    }
    
    @State var swapScorer = false // default ouest/est
        
    @EnvironmentObject var calcModel: CalcModel
    @State var game = Game()

    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var buttonPressed: Bool = false
    @State var scaleTimer: CGFloat = 1
    
    // true = OO, false = NS
    @State var stateTeamEnteringScore: Bool = true
    
    @State var offSetImage: CGFloat = 0
    @State var scaleSwapButton: CGFloat = 1
   
    
    let sizeKeysHere: CGFloat = 75
    @State var selectionPlayer: CasesSelections

    @State private var isScoreMaxChoiceMade: Bool = false
    @State private var isOkTapMade: Bool = false
    @State private var isValidateTapMade: Bool = false
    @State private var isFirstTapMade: Bool = false
    
    @State var isSelectionDone: Bool = false
    @State var showGame: Bool = false
    @State private var animationNames: Bool = false
    @State var showCalc: Bool = false
    
    
    @State private var anglePlayerView: Double = 0
    @State private var degree: Double = 0
    
    @State private var angleRotationArrow: Double = 0
    
    @State private var scalePlayerViewAnimation: CGFloat = 1
    @State private var scaleNord: CGFloat = 1
    @State private var scaleArrowAnimation: CGFloat = 0
    
    @State private var doneNord = false
    @State private var animationAmount: CGFloat = 0
    
    @State var isScoreTaped: Bool = false
    
    @Environment(\.managedObjectContext) var saving
    
    func saveGame() {
        
        let newParteFull = GameSaved(context: saving)

        newParteFull.total_oo = Double(calcModel.scoreTotalOuestEst())
        newParteFull.total_ns = Double(calcModel.scoreTotalNordSud())
        newParteFull.winner = calcModel.winnerName
        newParteFull.date = calcModel.currentDateTime
        newParteFull.id = UUID()
                
        for round in calcModel.rounds {
            
            let rounds = RoundBelote(context: saving)
            
            rounds.score_oe = Int16(round.score_oe)
            rounds.score_ns = Int16(round.score_ns)
            rounds.ns_win = round.ns_win
            rounds.ns_deal = round.ns_deal
            rounds.id = UUID()

            newParteFull.addToRoundssaved(rounds)
            
            saveContext()

        }
        print(newParteFull)
        
        saveContext()

    }
    
    func saveContext() {
        do {
            try saving.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
    var questionViewThree: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 10)
            VStack {
                Text("3. Dès la partie terminée, enregistres le score en appuyant sur Nouvelle Donne.")
                Spacer().frame(height: 30)
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isOkTapMade = true
                    }
                    game.handlingStart(withStarter: game.dealer)
                } label: {
                    Text("OK !")
                        .modifier(ModifierActualAndPreviousRounds())
                    
                }
                .foregroundColor(.black)
            }
            .multilineTextAlignment(.center)
            .padding(5)
        }
        .padding(5)
    }
    
    var questionViewTwo: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 10)
            VStack {
                Text("2. Choisis le score à atteindre, puis valides ton choix.")
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 20)
                HStack {
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isScoreTaped  = true
                        }
                        calcModel.maxPoints = .Small
                    } label: {
                        Text("500")
                            .modifier(ModifierMaxPointsMenu())
                            .overlay {
                                if calcModel.maxPoints == .Small {
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.black, lineWidth: 4)
                                        .frame(width: 90, height: 45)
                                }
                            }
                    }
                    .foregroundColor(.black)
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isScoreTaped  = true
                        }
                        calcModel.maxPoints = .Medium
                    } label: {
                        Text("1000")
                            .modifier(ModifierMaxPointsMenu())
                            .overlay {
                                if calcModel.maxPoints == .Medium {
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.black, lineWidth: 4)
                                        .frame(width: 90, height: 45)
                                }
                            }
                    }
                    .foregroundColor(.black)
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isScoreTaped  = true
                        }
                        calcModel.maxPoints = .High
                    } label: {
                        Text("2000")
                            .modifier(ModifierMaxPointsMenu())
                            .overlay {
                                if calcModel.maxPoints == .High {
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.black, lineWidth: 4)
                                        .frame(width: 90, height: 45)
                                }
                            }
                    }
                    .foregroundColor(.black)
                    
                }
                .multilineTextAlignment(.center)
                .padding(5)
                Spacer().frame(height: 30)
                Button {
                    withAnimation {
                        isScoreMaxChoiceMade = true
                    }
                } label: {
                    Text("Valider")
                        .modifier(ModifierActualAndPreviousRounds())
                    
                }
                .disabled(!isScoreTaped)
                .foregroundColor(.black)
                .blur(radius: isScoreTaped ? 0 : 2)
                
            }
        }
        .padding(5)
    }
    
    var questionViewOne: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 10)
            
            VStack() {
                Text("1. Sélectionnes le joueur qui distribue la première donne, puis valides ton choix.")
                Spacer().frame(height: 30)
                
                Button {
                    withAnimation {
                        isValidateTapMade = true
                    }
                } label: {
                    Text("Valider")
                        .modifier(ModifierActualAndPreviousRounds())
                    
                }
                .disabled(!isFirstTapMade)
                .foregroundColor(.black)
                .blur(radius: isFirstTapMade ? 0 : 2)
            }
            .multilineTextAlignment(.center)
            .padding(5)
        }
        .padding(5)
        
    }
    
    var tableview: some View {
        ZStack {
            // player view
            VStack(alignment: .center,spacing: 0)  {
                PlayerView(isSud: false, position: game.player1.position!.rawValue,
                           isDealer: game.player1.action == .Dealer ? true : false,
                           isCutter: game.player1.action == .Cutter ? true : false,
                           color: Colors.nord_sud,
                           colorDealer: Colors.nord_sud)
                //                .rotationEffect(.degrees(anglePlayerView))
                    .scaleEffect(isOkTapMade ? 1.2 : scalePlayerViewAnimation)
                    .animateNamesForEver(autoreverses: true) { scalePlayerViewAnimation = 1.25 }
                    .onTapGesture {
                        if !isOkTapMade {
                            game.dealer = .Nord
                            selectionPlayer = .Nord
                            withAnimation(.easeIn(duration: 0.4)){
                                isFirstTapMade = true
                            }
                        }
                    }
                    .overlay {
                        if selectionPlayer == .Nord && !isOkTapMade {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.black, lineWidth: 4)
                                .frame(width: 90, height: 45)
                        }
                    }
              
                
                HStack(spacing: 0) {
                    PlayerView(isSud: false, position: game.player4.position!.rawValue,
                               isDealer: game.player4.action == .Dealer ? true : false,
                               isCutter: game.player4.action == .Cutter ? true : false,
                               color: Colors.est_ouest,
                               colorDealer: Colors.est_ouest)
                    //                    .rotationEffect(.degrees(anglePlayerView))
                        .scaleEffect(isOkTapMade ? 1.2 : scalePlayerViewAnimation)
                        .animateNamesForEver(autoreverses: true) { scalePlayerViewAnimation = 1.25 }
                        .onTapGesture {
                            if !isOkTapMade {
                            game.dealer = .Ouest
                            selectionPlayer = .Ouest
                            withAnimation(.easeIn(duration: 0.4)){
                                isFirstTapMade = true
                            }
                            }
                        }
                        .overlay {
                            if selectionPlayer == .Ouest && !isOkTapMade {
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.black, lineWidth: 4)
                                    .frame(width: 90, height: 45)
                            }
                        }
                    
                    Image("circle_table_01")
                        .resizable()
                        .rotationEffect(.degrees(degree))
                        .offset(y: 10)
                        .frame(width: 100, height: 100)
                    
                    PlayerView(isSud: false, position: game.player2.position!.rawValue,
                               isDealer: game.player2.action == .Dealer ? true : false,
                               isCutter: game.player2.action == .Cutter ? true : false,
                               color: Colors.est_ouest,
                               colorDealer: Colors.est_ouest)
                    //                    .rotationEffect(.degrees(anglePlayerView))
                        .scaleEffect(isOkTapMade ? 1.2 : scalePlayerViewAnimation)
                        .animateNamesForEver(autoreverses: true) { scalePlayerViewAnimation = 1.25 }
                        .onTapGesture {
                            if !isOkTapMade {
                            game.dealer =  .Est
                            selectionPlayer = .Est
                            withAnimation(.easeIn(duration: 0.4)){
                                isFirstTapMade = true
                            }
                            }
                        }
                        .overlay {
                            if selectionPlayer == .Est && !isOkTapMade {
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.black, lineWidth: 4)
                                    .frame(width: 90, height: 45)
                            }
                        }
                }
                
                PlayerView(isSud: true, position: game.player3.position!.rawValue,
                           isDealer: game.player3.action == .Dealer ? true : false,
                           isCutter: game.player3.action == .Cutter ? true : false,
                           color: Colors.nord_sud,
                           colorDealer: Colors.nord_sud)
                //                .rotationEffect(.degrees(anglePlayerView))
                    .scaleEffect(isOkTapMade ? 1.2 : scalePlayerViewAnimation)
                    .animateNamesForEver(autoreverses: true) { scalePlayerViewAnimation = 1.25 }
                    .onTapGesture {
                        if !isOkTapMade {
                        game.dealer = .Sud
                        selectionPlayer = .Sud
                        withAnimation(.easeIn(duration: 0.4)){
                            isFirstTapMade = true
                        }
                        }
                        
                    }
                    .overlay {
                        if selectionPlayer == .Sud && !isOkTapMade {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.black, lineWidth: 4)
                                .frame(width: 90, height: 45)
                        }
                    }
                
            }.onAppear(perform: {
                withAnimation {
                    degree = 360
                }
            })
            
            // arrow view
            if isOkTapMade {
                
                VStack(spacing: 115) {
                    HStack(spacing: 110) {
                        Image(systemName: "arrow.up.left").font(.system(size: 50)).rotationEffect(.degrees(280))
                        Image(systemName: "arrow.up.left").font(.system(size: 50))

                    }
                    HStack(spacing: 110) {
                        Image(systemName: "arrow.up.left").font(.system(size: 50)).rotationEffect(.degrees(180))
                        Image(systemName: "arrow.up.left").font(.system(size: 50)).rotationEffect(.degrees(90))

                    }
                }
                .rotationEffect(.degrees(angleRotationArrow))
                .scaleEffect(scaleArrowAnimation)
                .onAppear {
                    withAnimation {
                        scaleArrowAnimation = 1
                    }
                }
            }
        }
    }
    
    var scoreView: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 10)
            
            
            if !calcModel.rounds.isEmpty {
                Rectangle()
                    .foregroundColor(Colors.est_ouest)
                    .cornerRadius(3)
                    .frame(width: 13)
                    .offset(x: 72)
                
                Rectangle()
                    .foregroundColor(Colors.nord_sud)
                    .cornerRadius(3)
                    .frame(width: 13)
                    .offset(x: 162)
            }
                
            
            VStack {
                
                if !calcModel.rounds.isEmpty {
                    HStack {
                        Spacer()
                            .frame(width: 175)
                        
                        Text("Ouest \n Est")
                            .modifier(ModifierNameScoreView())
                        Text("Nord \n Sud")
                            .modifier(ModifierNameScoreView())
                    }
                }
                if !calcModel.rounds.isEmpty {
                    RowView(donneur: "\(game.dealer)", score_oe: 0, score_ns: 0, id: calcModel.rounds.count + 1, isDealer: true, colorDealer: game.dealer == .Est || game.dealer == .Ouest ? Colors.est_ouest : Colors.nord_sud)
                        .offset(x: 12)
                        .opacity(0.7)
                }
                
                if calcModel.rounds.isEmpty {
                    VStack {
                        Divider()
                        Spacer().frame(height: 30)
                        Text("Aucune partie n'a été enregistrée pour le moment.")
                            .multilineTextAlignment(.center)
                        Spacer().frame(height: 30)
                        Divider()
                        Spacer().frame(height: 30)
                        Text("Appuies sur Nouvelle Donne pour enregistrer la première partie.")
                            .multilineTextAlignment(.center)
                        Spacer().frame(height: 30)
                        Divider()
                    }
                    .padding(5)
                } else {
                    ScrollView {
                        ForEach(calcModel.rounds.sorted { $0.id > $1.id }, id: \.self) { round in
                            RowView(donneur: round.dealer, score_oe: round.score_oe, score_ns: round.score_ns,id: round.id, isDealer: true, colorDealer: round.ns_deal ? Colors.nord_sud : Colors.est_ouest)
                                .offset(x: 11)
//                                .background(Color.clear)
                            
                        }
                        
                    }
//                    .onAppear {
//                        UITableView.appearance().separatorColor  = .brown
//                        UITableView.appearance().backgroundColor = UIColor.clear
//                        UITableViewCell.appearance().backgroundColor = UIColor.clear
//                        UITableView.appearance().bounces = true
//                    }
//                    .padding(5)
                }
                if !calcModel.rounds.isEmpty {
                    HStack {
                        Spacer().frame(width: 85)
                        Text("TOTAL: ")
                            .modifier(ModifierNameScoreView())
                        Text("\(calcModel.scoreTotalOuestEst())")
                            .modifier(ModifierNameScoreView())
                        Text("\(calcModel.scoreTotalNordSud())")
                            .modifier(ModifierNameScoreView())
                    }
                }
                Spacer()
            }
        }
    }
    
    var nouvelledonne: some View {
        
        VStack {
            if showCalc {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 13, style: RoundedCornerStyle.continuous)
                        .stroke(lineWidth: 2)
                        .frame(width: 150, height: 55)
                        .background(Colors.background_namesview.cornerRadius(15))
                    Text("Valider score")
                        .foregroundColor(.black).bold()
                }
                
                .blur(radius: calcModel.isScoreOK ? 0 : 2)
                .onTapGesture {
                    print("isevrytime")
                   
                    calcModel.addRound(withDealer: game.dealer.rawValue)
                    
                    calcModel.resetCalc()
                    
                    if game.dealer == .Nord {
                        game.dealer = .Ouest
                        game.handlingStart(withStarter: game.dealer)
                    } else if game.dealer == .Est {
                        game.dealer = .Nord
                        game.handlingStart(withStarter: game.dealer)
                    } else if game.dealer == .Sud {
                        game.dealer = .Est
                        game.handlingStart(withStarter: game.dealer)
                    } else if game.dealer == .Ouest {
                        game.dealer = .Sud
                        game.handlingStart(withStarter: game.dealer)
                    } else  {
                        print("caca")
                    }
                    withAnimation(.easeIn(duration: 0.35)) {
                        showCalc.toggle()
                    }
                    withAnimation(Animation.spring(response: 0.55, dampingFraction: 0.45, blendDuration: 0)) {
                        anglePlayerView = 360
                    }
                    anglePlayerView = 0
                    withAnimation(.easeInOut(duration: 1)) {
                        angleRotationArrow -= 90
                    }
                }
                
            } else {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 13, style: RoundedCornerStyle.continuous)
                        .stroke(lineWidth: 2)
                        .frame(width: 150, height: 55)
                        .background(Colors.background_namesview.cornerRadius(15))
                    Text("Nouvelle donne")
                        .foregroundColor(.black).bold()
                }
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.35)) {
                        showCalc.toggle()
                    }
                }
                
            }
        }
        
    }
    
    var helpscoreview: some View {
        VStack {
            //            HStack(spacing: 5) {
            //                VStack {
            //                    HStack {
            //                        PlayerViewCalc(position: "Ouest", isDealer: false, color: Colors.est_ouest)
            //                        PlayerViewCalc(position: "Est", isDealer: false, color: Colors.est_ouest)
            //                    }
            //                    Text("Score: 0").modifier(ModifierActualAndPreviousRounds())
            //                }
            //                VStack {
            //                    HStack {
            //                        PlayerViewCalc(position: "Nord", isDealer: false, color: Colors.nord_sud)
            //                        PlayerViewCalc(position: "Sud", isDealer: false, color: Colors.nord_sud)
            //                    }
            //                    Text("Score: 0").modifier(ModifierActualAndPreviousRounds())
            //                }
            //            }
            Text("Sélectionnes l'équipe ou tu veux rentré le score en premier, puis laisse toi guider!")
            
        }
    }//nothing
    
    var messagetop: some View {
        HStack {
            
            Text("Donneur actuel: \(isValidateTapMade ? game.dealer.rawValue : "")")
                .modifier(ModifierTopMessage())
//                .position(x: UIScreen.main.bounds.width * 1.5 / 6)
  
            Text("Score max: \( isScoreMaxChoiceMade ? String(calcModel.maxPoints.rawValue) : "")")
                .modifier(ModifierTopMessage())
//                .position(x: UIScreen.main.bounds.width * 2 / 6)
        }
        .frame(height: 50)
    }
        
    var calcView: some View {
       
            VStack(spacing: 0) {
                
                HStack(spacing: 15) {
                    Spacer()
                    ZStack {
                        
                        VStack {
                            PlayerViewCalc(isOuestEst: true, color: Colors.est_ouest)
                            PlayerViewCalc(isOuestEst: false, color: Colors.nord_sud)
                        }
                        
                        LinearGradient(colors: [Colors.nord_sud, Colors.est_ouest], startPoint: .top, endPoint: .bottom)
                            .frame(width: 50, height: 50)
                            .mask {
                                Image(systemName: "arrow.up.arrow.down.circle")
                                    .font(.system(size: 50))
                                    
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    
//                                    if !stateTeamEnteringScore {
//                                        calcModel.score_ouestest = "\(calcModel.getHelp())"
//                                    }  else if stateTeamEnteringScore {
//                                        calcModel.score_nordsud = "\(calcModel.getHelp())"
//                                    }
                                    stateTeamEnteringScore.toggle()
                                    
                                }
                                withAnimation(.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
                                    if offSetImage == -35 {
                                        offSetImage = 0
                                    } else if offSetImage == 0 {
                                        offSetImage = -35
                                    }
                                }
                            }
                            .scaleEffect(scaleSwapButton)
                            .onAppear(perform: {
                                withAnimation(.easeInOut(duration: 0.3).repeatForever(autoreverses: true)) {
                                    scaleSwapButton = 1.2
                                }
                            })
                            .offset(x: -85, y: 0)


                    }
                    
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(lineWidth: 2)
                                .frame(width: 70, height: 45)
                                .background(Colors.background_namesview.cornerRadius(10))
                            Text(calcModel.score_ouestest)
                                .font(.system(size: 30)).bold()
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(lineWidth: 2)
                                .frame(width: 70, height: 45)
                                .background(Colors.background_namesview.cornerRadius(10))
                            Text(calcModel.score_nordsud)
                                .font(.system(size: 30)).bold()
                        }
                    }
                    Spacer()
                    
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10, style: .continuous)
//                            .stroke(lineWidth: 2)
//                            .frame(width: 70, height: 45)
//                            .background(Colors.background_namesview.cornerRadius(10))
//                        Text(calcModel.scoreHelp == 0 ? String(calcModel.scoreHelp) : "")
//                            .font(.system(size: 30)).bold()
//                    }
                    
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(stateTeamEnteringScore ? Colors.est_ouest : Colors.nord_sud)
                        .offset(x: offSetImage, y: stateTeamEnteringScore ? -27 : 27)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
                                offSetImage = -35
                            }
                        }
                        
                }
//                .onTapGesture {
//                    withAnimation(.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
//                        if offSetImage == -35 {
//                            offSetImage = 0
//                        } else if offSetImage == 0 {
//                            offSetImage = -35
//                        }
//                    }
//                    withAnimation(.easeInOut(duration: 0.4)) {
//                        stateTeamEnteringScore.toggle()
//                    }
//                }
                .padding()
                
                Divider()
                
                // la calc
                VStack(spacing: -30) {
                    
                    HStack(spacing: -35) {
 
                        
                        Button {
                            calcModel.handlePressed(withNumber: 1, andState: stateTeamEnteringScore)
                            
                        } label: {
                            Image(systemName: "1.square")
                                .font(.system(size: sizeKeysHere))
                        }
                        
                        Button {
                            calcModel.handlePressed(withNumber: 2, andState: stateTeamEnteringScore)
                            
                        } label: { Image(systemName: "2.square").font(.system(size: sizeKeysHere)) }
                        Button {
                            calcModel.handlePressed(withNumber: 3, andState: stateTeamEnteringScore)
                            
                        } label: { Image(systemName: "3.square").font(.system(size: sizeKeysHere)) }
                    }
                    HStack(spacing: -35) {
    //                    Button { print("ah") } label: { Image(systemName: "square").font(.system(size: sizeKeysHere)) }
                        
                        Button {
                            calcModel.handlePressed(withNumber: 4, andState: stateTeamEnteringScore)
                            
                        } label: { Image(systemName: "4.square").font(.system(size: sizeKeysHere)) }
                        
                        Button {
                            calcModel.handlePressed(withNumber: 5, andState: stateTeamEnteringScore)
                            
                        } label: { Image(systemName: "5.square").font(.system(size: sizeKeysHere)) }
                        
                        Button {
                            calcModel.handlePressed(withNumber: 6, andState: stateTeamEnteringScore)
                            
                        } label: { Image(systemName: "6.square").font(.system(size: sizeKeysHere)) }

                    }
                    
                    HStack(spacing: -35) {
    //                    Button { print("ah") } label: { Image(systemName: "square").font(.system(size: sizeKeysHere)) }
                        Button {
                            calcModel.handlePressed(withNumber: 7, andState: stateTeamEnteringScore)
                        } label: { Image(systemName: "7.square").font(.system(size: sizeKeysHere)) }
                        
                        Button {
                            calcModel.handlePressed(withNumber: 8, andState: stateTeamEnteringScore)
                            
                        } label: { Image(systemName: "8.square").font(.system(size: sizeKeysHere)) }
                        
                        Button {
                            calcModel.handlePressed(withNumber: 9, andState: stateTeamEnteringScore)
                            
                        } label: { Image(systemName: "9.square").font(.system(size: sizeKeysHere)) }
                    }
                    
                    HStack(spacing: 40) {
    //                    Spacer().frame(width: 145)
                        Button { calcModel.handlePressed(withNumber: 0, andState: stateTeamEnteringScore) } label: { Image(systemName: "0.square").font(.system(size: sizeKeysHere)) }
                        Button { calcModel.deleteLastDigit(forState: stateTeamEnteringScore) } label: { Image(systemName: "delete.backward").font(.system(size: sizeKeysHere)) }
                    }
                }
                .buttonStyle(GrowingButton(color: stateTeamEnteringScore ? Colors.est_ouest : Colors.nord_sud))
               
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(stateTeamEnteringScore ? Colors.est_ouest : Colors.nord_sud, lineWidth: 8)
            )
        }
    
    var gameoverview: some View {
        VStack(spacing: 20) {
            Text("Belle partie !")
            Divider()
            Text("L'équipe \(calcModel.winnerName) a remporté la partie !")
            Divider()
            Text("Score Final: \(calcModel.scoreTotalNordSud()) à \(calcModel.scoreTotalOuestEst())")
            
            Button {
                viewRouter.currentView = .main
                
            } label: {
                Text("MENU PRINCIPAL")
                    .modifier(TextMenuModifier())
                
            }
            Spacer()

        }
    }
    
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 25) {
            
            if calcModel.isGameOverVar {
                gameoverview
                    .onAppear {
                        saveGame()
                    }

            } else {
                messagetop
                    .blur(radius: isFirstTapMade ? 0 : 2)
                if !showCalc {
                    tableview
                }
                
                if isOkTapMade {
                    if showCalc {
                        calcView
                    } else {
                        scoreView
                    }
                } else {
                    if !isValidateTapMade {
                        questionViewOne
                            .transition(.slide)
                    } else if !isScoreMaxChoiceMade && isValidateTapMade {
                            questionViewTwo
                                .transition(.slide)
                    } else {
                            questionViewThree
                                .transition(.slide)
                    }
                    
                }
                
                Spacer()
                
                nouvelledonne
                    .blur(radius: isOkTapMade ? 0 : 2)
                    .disabled(isNouvelleDonneDisabled())
            }
        }
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
//        GameView(selectionPlayer: .Est, isSelectionDone: true, showGame: true, showCalc: false)
        GameView.RowView(donneur: "Nord", score_oe: 100, score_ns: 62, id: 10, isDealer: true, colorDealer: Colors.est_ouest)
//        GameView(selectionPlayer: .Est, isSelectionDone: true, showGame: true, showCalc: false, isScoreTaped: true)
    }
}
