//
//  FinancialFreedomData.swift
//  FinancialFreedomCalculator
//
//  Created by BeastMode on 12/18/24.
//

import SwiftUI
import Foundation

class FinancialFreedomData: ObservableObject {
    
    @Published var downPayment: Double = 0
    @Published var maxLoanAmount: Double = 0
    @Published var monthlyPayment: Double = 0
    @Published var grossIncome: Double? = nil
    @Published var interestRate: Double? = nil
    @Published var carPrice: Double = 0
    var error: ValidationErrors? = nil
    
    
    //    (1 + r/n)^-nt
    var ratePower: Double {
        pow(1 + rate, -36)
    }
    
    // ( r / n )
    var rate: Double {
        
        interestRate!/12
        
    }
    
    func calculateCarPayments() {
        
        monthlyPayment = grossIncome!*0.08
        
        //        MP * [ 1 - (1 + r/n)^-nt ]  = P
        //        —————————————
        //        ( r / n )
        
        let top = monthlyPayment * (1 - ratePower)
        
        maxLoanAmount = top/rate
        
        downPayment = (maxLoanAmount/0.8) * 0.2
        
        carPrice = maxLoanAmount + downPayment
        
    }
    
    func validateFields() throws {
        
        if interestRate != nil && interestRate != 0{}
        else
        {
            error = .interestError
            throw error!
        }
        
        if grossIncome != nil && grossIncome != 0{}
        else
        {
            error = .grossIncomeError
            throw error!
        }
        
    }
    
}


enum ValidationErrors: LocalizedError {
    
    case interestError
    case grossIncomeError
    
    var errorDescription: String? {
        
        switch self {
            
        case .interestError:
            return "Interest Rate Error"
            
        case .grossIncomeError:
            return "Gross Income Error"
        }
    }
    
    
    var errorSuggestion: String? {
        
        switch self {
        
        case .interestError:
            return "Please enter a valid interest rate"
            
        case .grossIncomeError:
            return "Please enter a valid gross income"
            
        }
    }
}
