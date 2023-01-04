//
//  RemovePlant.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-29.
//

import Foundation
import SwiftUI
import Combine

struct RemovePlant: View{
    @State private var showingAlert = false
    @StateObject var plantitems: PlantItems
    @Binding var rootIsActive: Bool
    @Environment(\.colorScheme) var colorScheme
    @StateObject var selectedplant: SelectedPlant
    
    var body: some View{
        Button(action: {showingAlert = true}){
            VStack{
                ZStack{
                    Circle().frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.red)
                    Circle().frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(colorScheme == .dark ? .black : .white)
                    Image(systemName: "minus").foregroundColor(.red)
                }
                Text("Remove").foregroundColor(.red)
            }        }.alert(isPresented: $showingAlert, content: {
                Alert(
                    title: Text("Are you sure?"), primaryButton: .destructive(Text("yes"), action: remove), secondaryButton: .cancel()
                )
            })
    }
    
    func remove()
    {
        let x: Int = plantitems.plantsOwned.firstIndex(where: {$0 == selectedplant.selectedplant}) ?? 0
        plantitems.plantsOwned.remove(at: x)
        self.plantitems.save()
        self.rootIsActive = false
    }
}

