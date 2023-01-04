//
//  VitaPotApp.swift
//  VitaPot
//
//  Created by Alex Yoshida on 2021-10-28.
//

import SwiftUI

@main
struct VitaPotApp: App {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.colorScheme, isDarkMode ? .dark: .light).preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
