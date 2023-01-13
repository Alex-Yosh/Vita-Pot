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
    
    var body: some View{
        VStack(alignment: HorizontalAlignment.leading){
            Text(title).font(.headline)
            TextField("Enter \(title)", text: $userInput).textFieldStyle(RoundedBorderTextFieldStyle())
        }.padding()
    }
    
}


struct AddNewPlant: View{
    
    @State private var bgColor =
        Color(.sRGB, red: 1.0, green: 1.0, blue: 1.0)
    @Binding var rootIsActive: Bool
    @StateObject var plantitems: PlantItems
    @State private var name: String = ""
    @State private var typeofplant: String = ""
    @State private var nameNotification = ""
    @State private var typeNotification = ""
    @State var selected: Plant = Plant(catagory: "", Favour: false)
    
    
    var body: some View{
        Form{
            Section(header: Text("Plant Details")){
                VStack{
                    DataInput(title: "Name", userInput: $name)
                    Text(nameNotification).foregroundColor(.red).fontWeight(.light).font(.system(size: 15)).frame(alignment: .leading)
                    DataInput(title: "Type of Plant", userInput: $typeofplant)
                    Text(typeNotification).foregroundColor(.red).fontWeight(.light).font(.system(size: 15)).frame(alignment: .leading)
                    ZStack{
                        Text("Pick Colour:")
                        ColorPicker("", selection: $bgColor, supportsOpacity: false).offset(x: -85)
                    }.offset(x: -15)
                }
            }
            List(){
                Text("Pick a Catagory:")
                ForEach(0...4, id: \.self){i in
                    Listitem(item: plantInfo[i], selected: $selected)
                }
            }
            
        }
        Button(action: {
            let x:Bool = canPassName()
            let y:Bool = canPassType()
            
            if(x && y){
                addNewPlant()
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
            Text("Add Plant")
        }.disabled(name == "" || selected.catagory == "" || typeofplant == "" || bgColor ==
                    Color(.sRGB, red: 1.0, green: 1.0, blue: 1.0))
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
        
        if (name.count > 12)
        {
            nameNotification = "Name Too Long"
            return false
        }
        
        return true
    }
    
    func canPassType() ->Bool{
        if (typeofplant.count > 12)
        {
            typeNotification = "Type of Plant is Too Long"
            return false
        }
        
        return true
    }
    
}
