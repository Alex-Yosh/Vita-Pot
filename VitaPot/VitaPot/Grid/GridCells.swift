//
//  GridCells.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-30.
//

import Foundation
import SwiftUI

struct CellContent: View{
    @StateObject var selectedplant: SelectedPlant
    @State private var rootIsActive: Bool = false
    @StateObject var plantitems: PlantItems
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View{
        NavigationLink(destination: PlantDetail(plantitems: self.plantitems, rootIsActive: self.$rootIsActive, selectedplant: selectedplant), isActive: self.$rootIsActive){
        ZStack{
            Rectangle().frame(minWidth: 100, maxWidth: .infinity, minHeight: 150).foregroundColor(Color(.sRGB, red: Double(Float(selectedplant.selectedplant.red!)), green: Double(Float(selectedplant.selectedplant.green!)), blue: Double(Float(selectedplant.selectedplant.blue!)))).border(pickcolour(), width: 5).cornerRadius(10)
            Image("\(selectedplant.selectedplant.catagory)").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100, alignment: .leading).offset(x: -40)
            VStack{
                    Text(selectedplant.selectedplant.name!)
                    Text("the")
                    Text(selectedplant.selectedplant.type!)
            }.offset(x: 30).foregroundColor(invertedpickcolour()).font(Font.custom("Letters for Learners", size: 25))
        }.padding(10)
        }.offset(y:80)
    }
    
    func pickcolour()->Color{
        if (selectedplant.selectedplant.Favour == true){
            return Color.yellow
        }
    
        return (colorScheme == .dark ? Color.white : Color.black)
    }
    
    func invertedpickcolour()->Color{
        if (selectedplant.selectedplant.Favour == true){
            return Color.yellow
        }
    
        return (colorScheme == .dark ? Color.black : Color.white)
    }
}



struct EmptyCell: View{
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        ZStack{
            Rectangle().frame(minWidth: 100, maxWidth: .infinity, minHeight: 150).foregroundColor(.clear).border(colorScheme == .dark ? Color.white : Color.black, width: 5).cornerRadius(10)
        }.padding(10).offset(y:80)
    }
}


struct AddCell: View{
    
    @State var ToRoot: Bool = false
    @StateObject var plantitems: PlantItems
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View{
        ZStack{
            Rectangle().frame(minWidth: 100, maxWidth: .infinity, minHeight: 150).foregroundColor(.clear).border(colorScheme == .dark ? Color.white : Color.black, width: 5).cornerRadius(10)
            NavigationLink(
                destination: AddNewPlant(rootIsActive: $ToRoot, plantitems: plantitems), isActive: $ToRoot){
                ZStack{
                    Circle().frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(colorScheme == .dark ? Color(.sRGB, red: 0.250, green: 0.250, blue: 0.250):Color(.sRGB, red: 0.950, green: 0.950, blue: 0.950))
                    Image(systemName: "plus").resizable().foregroundColor(colorScheme == .dark ? Color.black : Color.white).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                }
        }.padding(10).offset(y:80)
        
    }
}
