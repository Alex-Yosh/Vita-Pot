//
//  Greetings.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-30.
//

import Foundation
import SwiftUI

struct Intro: View{
    var body: some View{
        Text(greeting()).font(Font.custom("Letters for Learners", size: 40))
    }
}

func greeting() ->String{
    let date = NSDate()
    let calender = NSCalendar.current
    let hour = calender.component(.hour, from: date as Date)
    let hourInt = Int(hour.description)!
    
    switch(hourInt)
    {
        case 0...6:
            return "You should sleep"
        case 7...11:
            return "Good Morning"
        case 12...16:
            return "Good Afternoon"
        case 17...20:
            return "Good Evening"
        default:
            return "Good Night"
    }
}
