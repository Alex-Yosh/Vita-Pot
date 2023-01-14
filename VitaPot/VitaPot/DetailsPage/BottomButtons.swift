//
//  File.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-30.
//

import Foundation
import SwiftUI

struct FavouriteButton: View{
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

struct EditPlantButton: View{
    @StateObject var plantitems: PlantItems
    @State var back:Bool = false
    @StateObject var selectedplant: SelectedPlant
    
    var body: some View{
        NavigationLink(
            destination: PlantFormScreen(selectedplant: selectedplant, rootIsActive: $back, plantitems: plantitems, isEditting: true), isActive: $back,
            label: {
                VStack{
                    ZStack{
                        Image(systemName: "gearshape.fill").resizable().frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    Text("Edit")
                }.foregroundColor(.blue)
            })
    }
}


struct CannotSelectButton: View{
    @Environment(\.colorScheme) var colorScheme
    var title:String
    var body: some View{
            VStack{
                ZStack{
                    Circle().frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.gray)
                    Circle().frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(colorScheme == .dark ? .black : .white)
                    Image(systemName: "lock.fill").resizable().foregroundColor(.gray).frame(width: 16, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Text(title)
            }.foregroundColor(.gray)
    }
}

struct RemovePlantButton: View{
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


