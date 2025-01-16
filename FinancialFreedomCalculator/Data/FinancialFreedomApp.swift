//
//  FinancialFreedomCalculatorApp.swift
//  FinancialFreedomCalculator
//
//  Created by BeastMode on 12/18/24.
//

import SwiftUI

@main
struct FinancialFreedomApp: App {
    
    init(){
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.blue]
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().isTranslucent = true
    }
    
    var body: some Scene {
        WindowGroup {
            HomePage()
        }
    }
}
