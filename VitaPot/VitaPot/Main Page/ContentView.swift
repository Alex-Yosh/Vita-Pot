//
//  ContentView.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-28.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView{
            ZStack(){
                Image(colorScheme == .dark ? "DarkTitle" : "Title").resizable().aspectRatio(contentMode: .fit).padding().offset(y:-350)
                HStack{
                    Intro()
                    DarkModeButton()
                    
                }.offset(y: -250)
            PlantGrid()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

 
