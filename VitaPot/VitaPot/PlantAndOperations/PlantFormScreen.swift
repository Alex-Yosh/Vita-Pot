//
//  File.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-28.
//

import Foundation
import SwiftUI
import Combine

struct DataInput:View{
    var title: String
    @Binding var userInput: String
    var previousText: String = ""
    var typeNotification: String
    
    var body: some View{
        VStack(alignment: HorizontalAlignment.leading){
            Text(title).font(.headline)
            TextField(previousText, text: $userInput).textFieldStyle(RoundedBorderTextFieldStyle())
            Text(typeNotification).foregroundColor(.red).fontWeight(.light).font(.system(size: 15)).frame(alignment: .leading)
        }.padding()
    }
    
}


struct PlantFormScreen: View{
    @State var selectedplant: SelectedPlant?
    @State private var bgColor =
    Color(.sRGB, red: 1.0, green: 1.0, blue: 1.0)
    @Binding var rootIsActive: Bool
    @StateObject var plantitems: PlantItems
    var isEditting: Bool
    @State private var name: String = ""
    @State private var typeofplant: String = ""
    @State private var nameNotification = ""
    @State private var typeNotification = ""
    @State var selected: Plant = Plant(catagory: "", Favour: false)
    
    
    var body: some View{
        Form{
            Section(){
                VStack{
                    DataInput(title: "Name", userInput: $name, previousText: selectedplant?.selectedplant.name! ?? "", typeNotification: nameNotification)
                    DataInput(title: "Type of Plant", userInput: $typeofplant, previousText: selectedplant?.selectedplant.type! ?? "", typeNotification: typeNotification)
                    HStack{
                        Text("Pick Colour")
                        ColorPicker("", selection: $bgColor, supportsOpacity: false).frame(alignment: .leading)
                    }
                }
            }
            List(){
                Text("Pick a Catagory:")
                ForEach(0...4, id: \.self){i in
                    Listitem(item: plantInfo[i], selected: $selected)
                }
            }
            
        }.onAppear(perform: {
            bgColor = Color(.sRGB, red: Double(Float(selectedplant?.selectedplant.red! ?? 1.0)), green: Double(Float(selectedplant?.selectedplant.green! ?? 1.0)), blue: Double(Float(selectedplant?.selectedplant.blue! ?? 1.0)))
            selected = selectedplant?.selectedplant ?? Plant(catagory: "", Favour: false)
        })
        Button(action: {
            let x:Bool = canPassName()
            let y:Bool = canPassType()
            
            if(x && y){
                if (isEditting){
                    edit()
                }else{
                    addNewPlant()
                }
                self.rootIsActive = false
                self.plantitems.save()
            }
            if (x){
                nameNotification = ""
            }
            if (y){
                typeNotification = ""
            }
            
        }){
            Text(isEditting ? "Confirm" : "Add Plant")
        }.disabled(!isEditting && (name == "" || selected.catagory == "" || typeofplant == "" || bgColor ==
                   Color(.sRGB, red: 1.0, green: 1.0, blue: 1.0)))
    }
    
    func edit(){
        let x: Int = plantitems.plantsOwned.firstIndex(where: {$0 == selectedplant!.selectedplant}) ?? -1
        if (name != "")
        {
            selectedplant!.selectedplant.name = name
        }
        if (typeofplant != "")
        {
            selectedplant!.selectedplant.type = typeofplant
        }
        if (bgColor !=
            Color(.sRGB, red: 1.0, green: 1.0, blue: 1.0)){
            let y = bgColor.cgColor?.components
            selectedplant!.selectedplant.red = y?[0]
            selectedplant!.selectedplant.green = y?[1]
            selectedplant!.selectedplant.blue = y?[2]
        }
        if (x>=0){
            selectedplant!.selectedplant.catagory = selected.catagory
            plantitems.editplant(x, selectedplant!.selectedplant)
        }
    }
    
    
    func addNewPlant(){
        let x = bgColor.cgColor?.components
        let red = x?[0]
        let green = x?[1]
        let blue = x?[2]
        let newPlant = Plant(name:name, catagory: selected.catagory, type: typeofplant, red: red, blue: blue, green: green, Favour: false)
        plantitems.plantsOwned.append(newPlant)
    }
    
    func canPassName() ->Bool{
        for plant in plantitems.plantsOwned{
            if (plant.name == name)
            {
                nameNotification = "Cannot Repeat Name"
                return false
            }
        }
        
        if (name.count > 8)
        {
            nameNotification = "Name Too Long"
            return false
        }
        
        return true
    }
    
    func canPassType() ->Bool{
        if (typeofplant.count > 8)
        {
            typeNotification = "Type of Plant is Too Long"
            return false
        }
        
        return true
    }
    
}
