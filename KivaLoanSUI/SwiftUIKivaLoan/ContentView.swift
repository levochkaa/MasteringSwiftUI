//
//  ContentView.swift
//  SwiftUIKivaLoan
//
//  Created by Simon Ng on 29/11/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var loanStore = LoanStore()
    
    @State private var filterEnabled = false
    @State private var maximumLoanAmount = 10000.0
    
    var body: some View {
        NavigationView {
            VStack {
                if filterEnabled {
                    LoanFilterView(amount: self.$maximumLoanAmount)
                        .transition(.opacity)
                }
                
                List(loanStore.loans) { loan in
                    
                    LoanCellView(loan: loan)
                        .padding(.vertical, 5)
                }
            }
      
            .navigationBarTitle("Kiva Loan")
            
            .navigationBarItems(trailing:
                Button(action: {
                    withAnimation(.linear) {
                        self.filterEnabled.toggle()
                        self.loanStore.filterLoans(maxAmount: Int(self.maximumLoanAmount))
                    }
                    
                }) {
                    Text("Filter")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            )
            
        }
        .navigationViewStyle(.stack)
        .onAppear() {
            self.loanStore.fetchLatestLoans()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
