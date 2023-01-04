//
//  EditPlant.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-30.
//

import Foundation
import SwiftUI

struct EditPlantButton: View{
    @StateObject var plantitems: PlantItems
    @State var back:Bool = false
    @StateObject var selectedplant: SelectedPlant
    
    var body: some View{
        NavigationLink(
            destination: EditPlant(selectedplant: selectedplant, back: $back, plantitems: plantitems), isActive: $back,
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

struct EditPlant: View{
    @StateObject var selectedplant: SelectedPlant
    @Binding var back:Bool
    @State private var name: String = ""
    @State private var type: String = ""
    @State private var nameNotification = ""
    @State private var typeNotification = ""
    @StateObject var plantitems: PlantItems
    @State private var bgColor =
        Color(.sRGB, red: 1.0, green: 1.0, blue: 1.0)
    @State var selected: Plant = Plant(catagory: "", Favour: false)
    
    var body: some View{
        Form{
            Section(header: Text("Plant Details")){
                VStack(alignment: HorizontalAlignment.leading){
                    Text("Name").font(.headline)
                    TextField(selectedplant.selectedplant.name!, text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(nameNotification).foregroundColor(.red).fontWeight(.light).font(.system(size: 15)).frame(alignment: .leading)
                }.padding()
                VStack(alignment: HorizontalAlignment.leading){
                    Text("Type of Plant").font(.headline)
                    TextField(selectedplant.selectedplant.type!, text: $type).textFieldStyle(RoundedBorderTextFieldStyle())
                    Text(typeNotification).foregroundColor(.red).fontWeight(.light).font(.system(size: 15)).frame(alignment: .leading)
                }.padding()
                ZStack{
                    Text("Pick Colour:")
                    ColorPicker("", selection: $bgColor, supportsOpacity: false).offset(x: -85)
                }.offset(x: -15)
            }
            
            List(){
                Text("Pick a Catagory:")
                Listitem(item: plantInfo[0], selected: $selected)
                Listitem(item: plantInfo[1], selected: $selected)
                Listitem(item: plantInfo[2], selected: $selected)
                Listitem(item: plantInfo[3], selected: $selected)
                Listitem(item: plantInfo[4], selected: $selected)
            }
            
        }.onAppear(perform: {
            bgColor = Color(.sRGB, red: Double(Float(selectedplant.selectedplant.red!)), green: Double(Float(selectedplant.selectedplant.green!)), blue: Double(Float(selectedplant.selectedplant.blue!)))
            selected = selectedplant.selectedplant
        })
        Button(action: {
            let x:Bool = CanPassName()
            let y:Bool = CanPassType()
            
            if(x && y){
                if (plantitems.plantsOwned.count > 1)
                {
                    self.back = false
                }
                edit()
                self.plantitems.save()
            }
            if (x){
                nameNotification = ""
            }
            if (y){
                typeNotification = ""
            }
            
        }, label: {
            Text("Confirm")
        })
    }
    
    
   func edit(){
        let x: Int = plantitems.plantsOwned.firstIndex(where: {$0 == selectedplant.selectedplant}) ?? -1
        if (name != "")
        {
            selectedplant.selectedplant.name = name
        }
        if (type != "")
        {
            selectedplant.selectedplant.type = type
        }
        if (bgColor !=
                Color(.sRGB, red: 1.0, green: 1.0, blue: 1.0)){
            let y = bgColor.cgColor?.components
            selectedplant.selectedplant.red = y?[0]
            selectedplant.selectedplant.green = y?[1]
            selectedplant.selectedplant.blue = y?[2]
        }
    if (x>=0){
        selectedplant.selectedplant.catagory = selected.catagory
        plantitems.editplant(x, selectedplant.selectedplant)
    }
    }
    
    func CanPassName() ->Bool{
        for plant in plantitems.plantsOwned{
            if (plant.name == name)
            {
                nameNotification = "Cannot Repeat Name"
                return false
            }
        }
        
        if (name.count > 12)
        {
            nameNotification = "Name Too Long"
            return false
        }
        
        return true
    }
    
    func CanPassType() ->Bool{
        if (type.count > 12)
        {
            typeNotification = "Type of Plant is Too Long"
            return false
        }
        
        return true
    }
    
}
