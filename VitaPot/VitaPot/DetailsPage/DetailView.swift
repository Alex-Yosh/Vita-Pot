//
//  DetailView.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-28.
//

import Foundation
import SwiftUI
import Combine

struct PlantDetail: View{
    @StateObject var plantitems: PlantItems
    @Binding var rootIsActive: Bool
    @StateObject var selectedplant: SelectedPlant
    
    var body: some View{
        Form{
            HStack{
                Image("\(selectedplant.selectedplant.catagory)").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100, alignment: .leading)
                VStack{
                    Text(selectedplant.selectedplant.name!).frame(width: 300, alignment: .leading).font(Font.custom("Letters for Learners", size: 55))
                    Text("Catagory: \(selectedplant.selectedplant.catagory)").frame(width: 300, alignment: .leading).font(Font.custom("Letters for Learners", size: 35))
                    Text("Type: \(selectedplant.selectedplant.type!)").frame(width: 300, alignment: .leading).font(Font.custom("Letters for Learners", size: 35))
                }
            }
        }
        HStack{
            if (plantitems.plantsOwned.count > 1){
                Group{
                    Spacer()
                    if (OneFavoured() && selectedplant.selectedplant.Favour == false){
                        CannotSelect(title: "Favourite")
                    }
                    else{
                        Favourite(plantitems: plantitems, selectedplant: selectedplant)
                    }
                    Spacer()
                }
                Divider().frame(height:60)
                Group{
                    Spacer()
                    EditPlantButton(plantitems: plantitems, selectedplant: selectedplant)
                    Spacer()
                }
                Divider().frame(height:60)
                Group{
                    Spacer()
                    if (selectedplant.selectedplant.Favour == true){
                        CannotSelect(title: "Remove")
                    }else{
                        RemovePlant(plantitems: self.plantitems, rootIsActive: $rootIsActive, selectedplant: selectedplant)
                    }
                    Spacer()
                }
            }
        }
    }
    
    func OneFavoured()->Bool{
        for plant in plantitems.plantsOwned{
            if (plant.Favour == true)
            {
                return true
            }
        }
        return false
    }
}

