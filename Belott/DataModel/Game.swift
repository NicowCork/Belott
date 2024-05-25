//
//  ModelPickerGame.swift
//  Belott
//
//  Created by Nicolas Richard on 22/01/2022.
//

import Foundation



struct Game {
    
    enum Positions: String {
        case Nord = "Nord"
        case Ouest = "Ouest"
        case Sud = "Sud"
        case Est = "Est"
        case Random = "??"
    }
    
    enum GamesPlayed {
        case Belote
        case Coinche
        case None
    }
    
    
    enum StartersPosition: String {
        case Nord = "Nord"
        case Ouest = "Ouest"
        case Sud = "Sud"
        case Est = "Est"
        case Random = "Hasard"
    }
    

    
    var dealer: Positions = .Random
    
    var gamePlayed: GamesPlayed = .None
    
    
    mutating func resetGame() {
        dealer = .Random
    }
    
    mutating func handlingStart(withStarter: Positions)  {
        
        switch dealer {
        case .Nord:
            player1.action = .Dealer
//            player1.imageRole = .Starter
            
            player2.action = .Cutter
//            player2.imageRole = .None
            
            player3.action = .None
//            player3.imageRole = .Cutter
            
            player4.action = .Starter
//            player4.imageRole = .Dealer
        case .Est:
            player1.action = .Starter
//            player1.imageRole = .Dealer
            
            player2.action = .Dealer
//            player2.imageRole = .Starter
            
            player3.action = .Cutter
//            player3.imageRole = .None
            
            player4.action = .None
//            player4.imageRole = .Cutter
        case .Sud:
            player1.action = .None
//            player1.imageRole = .Cutter
            
            player2.action = .Starter
//            player2.imageRole = .Dealer
            
            player3.action = .Dealer
//            player3.imageRole = .Starter
            
            player4.action = .Cutter
//            player4.imageRole = .None
        case .Ouest:
            player1.action = .Cutter
//            player1.imageRole = .None

            player2.action = .None
//            player2.imageRole = .Cutter
            
            player3.action = .Starter
//            player3.imageRole = .Dealer

            player4.action = .Dealer
//            player4.imageRole = .Starter

        default:
            print("BIG BUG SHOULD NOT BE THERE")

            
        }
    }

    enum GamesPosition: String {
        case Cutter = "Coupeur!"
        case Dealer = "Donneur!"
        case Starter = "Commence"
        case None = ""
    }
    enum ImageRole: String {
        case Cutter = "checkmark.square.fill"
        case Dealer = "magazine.fill"
        case Starter = "rosette"
        case None = "cup.and.saucer"
    }
    var player1 = Player(position: .Nord) // NORD
    var player2 = Player(position: .Est) // EST
    var player3 = Player(position: .Sud) // SUD
    var player4 = Player(position: .Ouest) // OUEST

    struct Player {
        var position: Positions?
        var action: GamesPosition = .None
        var imageRole: ImageRole = .None
    }
  
}
