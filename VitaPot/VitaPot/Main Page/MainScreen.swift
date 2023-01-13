//
//  ContentView.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-28.
//

import SwiftUI

struct MainScreen: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView{
            VStack(){
                Image(colorScheme == .dark ? "DarkTitle" : "Title").resizable().aspectRatio(contentMode: .fit).padding(.horizontal, 10)
                HStack{
                    Intro()
                    DarkModeButton()
                }
                PlantGrid()
            }.navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}



struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainScreen()
        }
    }
}


