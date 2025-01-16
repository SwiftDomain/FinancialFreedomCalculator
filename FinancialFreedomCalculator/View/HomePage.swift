//
//  ContentView.swift
//  FinancialFreedomCalculator
//
//  Created by BeastMode on 12/18/24.
//

import SwiftUI

struct HomePage: View {
    
    //@StateObject
    @StateObject private var financialFreedom: FinancialFreedomData
    
    //@State
    @State private var path = NavigationPath()
    @State private var steps:[Int] = [1,2,3,4,5,6,7]
    @State private var showStep: Bool = false

    
    let layout = [
        GridItem(.adaptive(minimum: 950)),
    ]
    
    init() {
     
        _financialFreedom = StateObject(wrappedValue: FinancialFreedomData())
        
    }
    
    var body: some View {
        
        ZStack {
            NavigationStack(path: $path) {
                
                ScrollView(showsIndicators: false) {
                    
                    LazyVGrid(columns: layout) {
                        
                        VStack(spacing: 15) {
                            
                            ForEach(steps, id: \.self) { step in
                                
                                Button(action: {
                                    
                                    self.showStep.toggle()
                                })
                                {
                                    Text("SDF")
                                }
                            }
                        }
                    }
                }
                }
            .sheet(isPresented: $showStep)
            {
                CarAffordability(path: $path)
            }
            .refreshable {
                
            }
        }
        .environmentObject(financialFreedom)
        
    }
}

#Preview {
    HomePage()
}
