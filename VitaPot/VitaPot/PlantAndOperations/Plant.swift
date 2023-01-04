//
//  Plant.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-28.
//

import Foundation
import SwiftUI
import Combine

struct Plant: Codable, Identifiable, Equatable{
    var id = UUID()
    var name: String?
    var catagory: String
    var type:String?
    var red: CGFloat?
    var blue: CGFloat?
    var green: CGFloat?
    var Favour: Bool
}

class PlantItems: ObservableObject{
    @Published var plantsOwned: [Plant]
    
    
    init () {
        if let data = UserDefaults.standard.data(forKey: "SavedData"){
            if let decoded = try?JSONDecoder().decode([Plant].self, from: data){
                self.plantsOwned = decoded
                return
            }
        }
        self.plantsOwned = []
    }
    
    func editplant(_ index: Int, _ Changedplant: Plant){
        plantsOwned[index] = Changedplant
    }
    
    
    func save(){
        if let encoded = try? JSONEncoder().encode(plantsOwned){
            UserDefaults.standard.set(encoded, forKey: "SavedData")
        }
    }
}

class SelectedPlant: ObservableObject{
    @Published var selectedplant: Plant
    
    init(plant: Plant){
        selectedplant = plant
    }
}
