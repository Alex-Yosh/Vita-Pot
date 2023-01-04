//
//  Grid.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-28.
//
import Foundation
import SwiftUI


struct PlantGrid: View{
    @StateObject var plantitems: PlantItems = PlantItems()
    var gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View{
        LazyVGrid(columns: gridItems, spacing: 5){
            ForEach(plantitems.plantsOwned){ plants in
                CellContent(selectedplant: SelectedPlant(plant: plants), plantitems: plantitems)
            }
            if (plantitems.plantsOwned.count < 6){
                AddCell(plantitems: plantitems)
            }
            if(plantitems.plantsOwned.count+1 < 6){
                ForEach((0...4-plantitems.plantsOwned.count), id: \.self){ index in
                    EmptyCell()
                }
            }
        }
    }
}
