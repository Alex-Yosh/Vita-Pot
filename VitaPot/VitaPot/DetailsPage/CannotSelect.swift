//
//  CannotSelect.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-31.
//

import Foundation
import SwiftUI

struct CannotSelect: View{
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


