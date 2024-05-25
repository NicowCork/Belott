//
//  UserSettings.swift
//  Belott
//
//  Created by Nicolas Richard on 18/01/2022.
//

import Foundation
import UIKit

class UserSettings: ObservableObject {
    
    @Published var sonActiver: Bool {
        didSet {
            UserDefaults.standard.set(sonActiver, forKey: "sonActiver")
        }
    }
    @Published var autolockDisabled: Bool {
        didSet {
            UIApplication.shared.isIdleTimerDisabled = autolockDisabled
            UserDefaults.standard.set(autolockDisabled, forKey: "autolockDisabled")
        }
    }
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    @Published var colors_theme: String {
        didSet {
            UserDefaults.standard.set(colors_theme,forKey: "colors_theme")
        }
    }
    
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        self.sonActiver = UserDefaults.standard.object(forKey: "sonActiver") as? Bool ?? true
        self.autolockDisabled = UserDefaults.standard.object(forKey: "autolockDisabled") as? Bool ?? false
        self.colors_theme = UserDefaults.standard.object(forKey: "colors_theme") as? String ?? "theme_ocean"
    }
}
