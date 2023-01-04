//
//  File.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-30.
//

import Foundation
import SwiftUI

struct Favourite: View{
    @StateObject var plantitems: PlantItems
    @State var favoured:Bool = false
    @StateObject var selectedplant: SelectedPlant
    
    
    var body: some View{
        Button(action: {
            let x: Int = plantitems.plantsOwned.firstIndex(where: {$0 == selectedplant.selectedplant}) ?? 0
            if (favoured == true){
                favoured = false
                selectedplant.selectedplant.Favour = false
                plantitems.editplant(x, selectedplant.selectedplant)
                plantitems.save()
            } else{
                favoured = true
                selectedplant.selectedplant.Favour = true
                plantitems.editplant(x, selectedplant.selectedplant)
                plantitems.save()
            }
        }, label: {
            VStack{
                Image(systemName: favoured == true ? "star.fill" : "star").resizable().frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Favourite")
            }.foregroundColor(.yellow)
        }).onAppear(perform: {
            let x: Int = plantitems.plantsOwned.firstIndex(where: {$0 == selectedplant.selectedplant}) ?? 0
            favoured = plantitems.plantsOwned[x].Favour
        })
    }
}


