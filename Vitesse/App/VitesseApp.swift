//
//  VitesseApp.swift
//  Vitesse
//
//  Created by Jean Lejay on 4/8/26.
//

import SwiftUI

@main
struct VitesseApp: App {
    
    // session unique, globale, partagée
    @StateObject private var session = SessionViewModel()
    
    private let dependencies = AppDependencies()
    
    var body: some Scene {
        WindowGroup {
            RootView(dependencies: dependencies)
                .environmentObject(session)
        }
    }
}
