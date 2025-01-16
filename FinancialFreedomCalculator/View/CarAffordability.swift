//
//  CarAffordability.swift
//  FinancialFreedomCalculator
//
//  Created by BeastMode on 12/18/24.
//

import SwiftUI

struct CarAffordability: View {
    
    @EnvironmentObject var financialFreedom: FinancialFreedomData
    @Binding var path: NavigationPath
    
    @State private var showAlert = false
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image(systemName: "car.side.lock.open")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                
            Spacer()
            
            HStack
            {
                Text("Max Car Price")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                TextField("Max Car Price", value: $financialFreedom.carPrice, format: .currency(code: "USD"))
                    .multilineTextAlignment(.trailing)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(alignment: .trailing)
                    .disabled(true)
                
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            
            HStack
            {
                Text("Max Loan Amount")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                TextField("Max Loan Amount", value: $financialFreedom.maxLoanAmount, format: .currency(code: "USD"))
                    .multilineTextAlignment(.trailing)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(alignment: .trailing)
                    .disabled(true)
                
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            
            
            HStack
            {
                Text("20% Downpayment")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .frame(alignment: .leading)
                
                Spacer()
                
                TextField("Downpayment", value: $financialFreedom.downPayment, format: .currency(code: "USD"))
                    .multilineTextAlignment(.trailing)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(alignment: .trailing)
                    .disabled(true)
                
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            
            HStack
            {
                Text("Max Monthly Payment")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                TextField("Max Monthly Payment", value: $financialFreedom.monthlyPayment, format: .currency(code: "USD"))
                    .multilineTextAlignment(.trailing)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(alignment: .trailing)
                    .disabled(true)
                
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            
            HStack
            {
                Text("Interest Rate")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                TextField("*Interest Rate", value: $financialFreedom.interestRate, format: .percent)
                    .multilineTextAlignment(.trailing)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(alignment: .trailing)
                    .keyboardType(.numberPad)

            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            
            HStack
            {
                Text("Maximum Loan Years")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("3 Years")
                    .font(.headline)
                    .foregroundColor(.primary)
                
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            
            Divider()
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 40, trailing: 20))
            
            
            TextField("Monthly Gross Income", value: $financialFreedom.grossIncome, format: .currency(code: "USD"))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: 250)
                .keyboardType(.numberPad)
            
            Button("Calculate") {
                
                do{
                    try
                    financialFreedom.validateFields()
                    financialFreedom.calculateCarPayments()
                }
                catch{
                    showAlert = true
                }
                
            }
            .padding(.top, 20)
            .alert(isPresented: $showAlert, error: financialFreedom.error) { _ in
                Button("OK") {
                  showAlert = false
                }
              } message: { error in
                  Text(financialFreedom.error?.errorSuggestion ?? "Error")
              }
            
            Spacer()
            
            Text("Maximum monthly payment should be no more than 8% of monthly gross income.")
                .font(.callout)
                .foregroundColor(.gray)
                .padding()
            
            
            
        }
        
    }
}

//#Preview {
//    CarAffordability()
//}

struct CarAffordability_Previews: PreviewProvider {
    static var previews: some View {
        CarAffordability(path: .constant(NavigationPath()))
            .environmentObject(FinancialFreedomData())
    }
}
