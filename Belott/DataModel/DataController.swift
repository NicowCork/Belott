//
//  DataController.swift
//  Belott
//
//  Created by Nicolas Richard on 07/02/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "Belott")
        
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

