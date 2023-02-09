//
//  Art_PuzzleApp.swift
//  Art Puzzle
//
//  Created by Conner Tate on 12/2/22.
//

import SwiftUI

@main
struct Art_PuzzleApp: App {
    
    @StateObject var vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
            //Injects viewmodel
            .environmentObject(vm)
        }
    }
}
