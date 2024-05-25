//
//  CalcModel.swift
//  Belott
//
//  Created by Nicolas Richard on 26/01/2022.
//

import Foundation
import CoreData
import SwiftUI


class CalcModel: ObservableObject {

    
    let currentDateTime = Date()

    enum MaxPoints: Int {
        case Small = 500
        case Medium = 1000
        case High = 2000
    }
    
    @Published var maxPoints: MaxPoints = .Small
    
    
    struct Round: Hashable, Identifiable {
        var id: Int
        var score_ns: Int
        var score_oe: Int
        var ns_win: Bool
        var dealer: String
        var ns_deal: Bool
    }
   
    
    var rounds: [Round] = []
    
    var trashID: Int = 0
    
    func getUniqueID() -> Int {
        trashID += 1
        return trashID
    }
    
    
    // true ==  OO,  false = NS
    //    var state: Bool = true
    
    // displayed
    @Published var score_ouestest: String = "0"
    @Published var score_nordsud: String = "0"
    
    @Published var winnerName: String = ""
   
    @Published var isGameOverVar: Bool = false
   
    
    var score_total_ouestest: [Int] = []
    var score_total_nordsud: [Int] =  []
    
    //
    var currentOO: [Int] = []
    var currentNS: [Int] = []
    
    var numberpressed: Int = 0
 
    var bla: Int = 0
    
    func scoreTotalOuestEst() -> Int { score_total_ouestest.reduce(0, +) }
    func scoreTotalNordSud() -> Int { score_total_nordsud.reduce(0, +) }

    var isScoreOK: Bool {
        get {
            isScoreOkFunc()
        }
    }
    
//    var scoreHelp: Int {
//        get {
//            getHelp()
//        }
//    }
    
    // MARK: funnction plus appeler car ca fait la merde
    func getHelp() -> Int {
        
        if currentNS.count == 3 && currentOO.count == 0 {
            let currentsNS = currentNS[0] * 100 + currentNS[1] * 10 + currentNS[2]
            //need  to fill the opposite 00 or NS, t hen iscoreOKFunc can work
            
            return 162 - currentsNS
            
        } else if currentNS.count == 3 && currentOO.count == 1 {
            let currentsNS = currentNS[0] * 100 + currentNS[1] * 10 + currentNS[2]
            
            return 162 - currentsNS
            
        } else if currentNS.count == 2 && currentOO.count == 2 {
            let currentsOO = currentOO[0] * 10 + currentOO[1]
            let currentsNS = currentNS[0] * 10 + currentNS[1]
            
            if currentsNS > currentsOO {
                return 162 - currentsNS
            } else {
                return 162 - currentsOO
            }
        } else if currentNS.count == 3 && currentOO.count == 2 {
            let currentsNS = currentNS[0] * 100 + currentNS[1] * 10 + currentNS[2]
            
            return 162 - currentsNS
            
        } else if currentNS.count == 0 && currentOO.count == 3 {
            let currentsOO = currentOO[0] * 100 + currentOO[1] * 10 + currentOO[2]
            
            return 162 - currentsOO
            
        } else if currentNS.count == 1 && currentOO.count == 3 {
            let currentsOO = currentOO[0] * 100 + currentOO[1] * 10 + currentOO[2]
            
            return 162 - currentsOO
        } else if currentNS.count == 2 && currentOO.count == 3 {
            let currentsOO = currentOO[0] * 100 + currentOO[1] * 10 + currentOO[2]
            
            return 162 - currentsOO
        } else {
            print("default case for gethelpfunc")
            return 0
        }
    }
//    
   func isScoreOkFunc() -> Bool {
        
        if currentNS.count == 3 && currentOO.count == 0 {
            let currentsOO = 0
            let currentsNS = currentNS[0] * 100 + currentNS[1] * 10 + currentNS[2]
            
            if currentsOO + currentsNS == 162 || currentsOO + currentsNS == 182  || currentsOO + currentsNS == 252 || currentsNS + currentsOO == 272 {
                return true
            } else {
                return false
            }
            
        } else if currentNS.count == 3 && currentOO.count == 1 {
            let currentsOO = currentOO[0]
            let currentsNS = currentNS[0] * 100 + currentNS[1] * 10 + currentNS[2]
            
            if currentsOO + currentsNS == 162 || currentsOO + currentsNS == 182  || currentsOO + currentsNS == 252 || currentsNS + currentsOO == 272 {
                return true
            } else {
                return false
            }
            
        } else if currentNS.count == 3 && currentOO.count == 2 {
            let currentsOO = currentOO[0] * 10 + currentOO[1]
            let currentsNS = currentNS[0] * 100 + currentNS[1] * 10 + currentNS[2]
            
            if currentsOO + currentsNS == 162 || currentsOO + currentsNS == 182  || currentsOO + currentsNS == 252 || currentsNS + currentsOO == 272 {
                return true
            } else {
                return false
            }
        } else if currentNS.count == 2 && currentOO.count == 1 {
            let currentsOO = currentOO[0]
            let currentsNS = currentNS[0] * 10 + currentNS[1]
            
            if currentsOO + currentsNS == 162 || currentsOO + currentsNS == 182  || currentsOO + currentsNS == 252 || currentsNS + currentsOO == 272 {
                return true
            } else {
                return false
            }
        } else if currentNS.count == 2 && currentOO.count == 0 {
            let currentsOO = 0
            let currentsNS = currentNS[0] * 10 + currentNS[1]
            
            if currentsOO + currentsNS == 162 || currentsOO + currentsNS == 182  || currentsOO + currentsNS == 252 || currentsNS + currentsOO == 272 {
                return true
            } else {
                return false
            }
        } else if currentNS.count == 0 && currentOO.count == 2 {
            let currentsOO = currentOO[0] * 10 + currentOO[1]
            let currentsNS = 0
            
            if currentsOO + currentsNS == 162 || currentsOO + currentsNS == 182  || currentsOO + currentsNS == 252 || currentsNS + currentsOO == 272 {
                return true
            } else {
                return false
            }
        } else if currentNS.count == 1 && currentOO.count == 2 {
           let currentsOO = currentOO[0] * 10 + currentOO[1]
           let currentsNS = currentNS[0]
           
           if currentsOO + currentsNS == 162 || currentsOO + currentsNS == 182  || currentsOO + currentsNS == 252 || currentsNS + currentsOO == 272 {
               return true
           } else {
               return false
           }
       } else if currentNS.count == 2 && currentOO.count == 2 {
            let currentsOO = currentOO[0] * 10 + currentOO[1]
            let currentsNS = currentNS[0] * 10 + currentNS[1]
         
            if currentsOO + currentsNS == 162 || currentsOO + currentsNS == 182  || currentsOO + currentsNS == 252 || currentsNS + currentsOO == 272 {
                return true
            } else {
                return false
            }
            
        } else if currentNS.count == 0 && currentOO.count == 3 {
            let currentsOO = currentOO[0] * 100 + currentOO[1] * 10 + currentOO[2]
            let currentsNS = 0
            if currentsOO + currentsNS == 162 || currentsOO + currentsNS == 182  || currentsOO + currentsNS == 252 || currentsNS + currentsOO == 272 {
                return true
            } else {
                return false
            }
        } else if currentNS.count == 1 && currentOO.count == 3 {
            let currentsOO = currentOO[0] * 100 + currentOO[1] * 10 + currentOO[2]
            let currentsNS = currentNS[0]
            if currentsOO + currentsNS == 162 || currentsOO + currentsNS == 182  || currentsOO + currentsNS == 252 || currentsNS + currentsOO == 272 {
                return true
            } else {
                return false
            }
        } else if currentNS.count == 2 && currentOO.count == 3 {
            let currentsOO = currentOO[0] * 100 + currentOO[1] * 10 + currentOO[2]
            let currentsNS = currentNS[0] * 10 + currentNS[1]
            if currentsOO + currentsNS == 162 || currentsOO + currentsNS == 182  || currentsOO + currentsNS == 252 || currentsNS + currentsOO == 272 {
                return true
            } else {
                return false
            }
        } else {
            print("default case for isscoreokfunc")
            return false
        }
    }
    
    func isGameOverFunc() {
        switch maxPoints {
        case .Small:
            if scoreTotalNordSud() >= 500 {
                winnerName = "Nord / Sud"
                isGameOverVar = true
                
            } else if scoreTotalOuestEst() >= 500 {
                winnerName = "Ouest / Est"
                isGameOverVar = true
            } else {
                isGameOverVar = false
            }
        case .Medium:
            if scoreTotalNordSud() >= 1000 {
                winnerName = "Nord / Sud"
                isGameOverVar = true
            } else if scoreTotalOuestEst() >= 1000 {
                winnerName = "Ouest / Est"
                isGameOverVar = true
        
            } else {
                isGameOverVar = false
            }
        case .High:
            if scoreTotalNordSud() >= 2000 {
                isGameOverVar = true
                winnerName = "Nord / Sud"
            } else if scoreTotalOuestEst() >= 2000 {
                isGameOverVar = true
                winnerName = "Ouest / Est"
            } else {
                isGameOverVar = false
            }
        }
    }
    
    func addRound(withDealer dealer: String) {
        
        if let scoreOO = Int(score_ouestest), let scoreNS = Int(score_nordsud) {
            
            if scoreOO > scoreNS {
                let round = Round(id: getUniqueID(), score_ns: scoreNS, score_oe: scoreOO, ns_win: false, dealer: dealer, ns_deal: dealer == "Nord" || dealer == "Sud" ? true : false)
                score_total_ouestest.append(scoreOO)
                score_total_nordsud.append(scoreNS)
                rounds.append(round)
                
                isGameOverFunc()
                    
            } else if scoreOO < scoreNS {
                let round = Round(id: getUniqueID(), score_ns: scoreNS, score_oe: scoreOO, ns_win: true, dealer: dealer, ns_deal: dealer == "Nord" || dealer == "Sud" ? true : false)
                score_total_ouestest.append(scoreOO)
                score_total_nordsud.append(scoreNS)
                rounds.append(round)
                
                isGameOverFunc()
           
            }  else {
            print("You are trying to save agame wherethereis a  draw")
            }
        }
    }
    
    
    
    func resetCalc() {
        currentOO = []
        currentNS = []
        score_ouestest = "0"
        score_nordsud = "0"
    }
    
    func updateValueToDisplay(fromState state: Bool) {
        switch state {
        case true:
            if currentOO.count == 0 {
                score_ouestest = "0"
         
            }
            if currentOO.count == 1 {
                score_ouestest = "\(currentOO[0])"
            }
            if currentOO.count == 2 {
                score_ouestest = "\(currentOO[0])\(currentOO[1])"
            }
            if currentOO.count == 3 {
                score_ouestest = "\(currentOO[0])\(currentOO[1])\(currentOO[2])"
            }
            
        case false:
            if currentNS.count == 0 {
                score_nordsud = "0"
            }
            if currentNS.count == 1 {
                score_nordsud = "\(currentNS[0])"
            }
            if currentNS.count == 2 {
                score_nordsud = "\(currentNS[0])\(currentNS[1])"
            }
            if currentNS.count == 3 {
                score_nordsud = "\(currentNS[0])\(currentNS[1])\(currentNS[2])"
            }
            
        }
    }
    
    func deleteLastDigit(forState state: Bool) {
        switch state {
        case true:
            if currentOO.isEmpty {
                print("ahahitsempty")
            } else {
                currentOO.removeLast()
                updateValueToDisplay(fromState: state)
            }
        case false:
            if currentNS.isEmpty {
                print("ahahitsempty")
            } else {
                currentNS.removeLast()
                updateValueToDisplay(fromState: state)
            }
        }
    }
    
    func handlePressed(withNumber number: Int, andState state: Bool) {
        if currentOO.count >= 3 && state == true || currentNS.count >= 3 && state == false {
            print("playsound ?")
        } else {
            switch state {
            case true:
                currentOO.append(number)
                updateValueToDisplay(fromState: state)
            case false:
                currentNS.append(number)
                updateValueToDisplay(fromState: state)
            }
        }
    }
}
