//
//  DarkmodeButton.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-30.
//

import Foundation
import SwiftUI


struct DarkModeButton: View{
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    
    var body: some View{
        if (isDarkMode){
            DarkButton()
        }
        else{
            LightButton()
        }
    }
}

struct LightButton: View{
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    var body: some View{
        Button(action: {isDarkMode = true}, label: {
            Image(systemName: "sun.max.fill").resizable().foregroundColor(.yellow).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        })
    }
}

struct DarkButton: View{
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    var body: some View{
        Button(action: {isDarkMode = false}, label: {
            Image(systemName: "moon.stars.fill").resizable().foregroundColor(.yellow).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        })
    }
}
