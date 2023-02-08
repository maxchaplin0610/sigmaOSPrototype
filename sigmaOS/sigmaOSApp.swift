//
//  sigmaOSApp.swift
//  sigmaOS
//
//  Created by Max Chaplin on 05/02/2023.
//

import SwiftUI

@main
struct sigmaOSApp: App {
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                ContentView()
                    .environmentObject(SwiftUIWebViewModel())
                
                logoAnimationView()
                
            }
        }
    }
}
