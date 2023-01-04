//
//  PlantData.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-29.
//

import Foundation
import SwiftUI
import Combine

let plantInfo: [Plant] = [Plant(catagory:"Flower", Favour: false), Plant(catagory: "Tree", Favour: false), Plant(catagory: "Cactus", Favour: false),Plant(catagory:"Hanging", Favour: false),Plant(catagory:"Tropical", Favour: false) ]


struct Listitem: View{
    var item: Plant
    @Binding var selected: Plant
    
    var body: some View{
        HStack{
            Image(systemName: selected.catagory == item.catagory ? "leaf.fill": "leaf").foregroundColor(selected.catagory == item.catagory ? .green: .blue)
            Button(action: {selected = item}, label: {
                Text(item.catagory).foregroundColor(selected.catagory == item.catagory ? .green: .blue)
            })
        }
    }
    
}
