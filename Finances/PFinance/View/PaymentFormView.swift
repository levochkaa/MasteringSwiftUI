//
//  PaymentFormView.swift
//  PFinance
//
//  Created by Simon Ng on 11/9/2020.
//

import SwiftUI
import CoreData

struct PaymentFormView: View {

    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject private var paymentFormViewModel: PaymentFormViewModel
    
    var payment: PaymentActivity?
    
    init(payment: PaymentActivity? = nil) {
        self.payment = payment
        self.paymentFormViewModel = PaymentFormViewModel(paymentActivity: payment)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // Title bar
                HStack(alignment: .lastTextBaseline) {
                    Text("New Payment")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.black)
                        .padding(.bottom)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "multiply")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
                
                Group {
                    if !paymentFormViewModel.isNameValid {
                        ValidationErrorText(text: "Please enter the payment name")
                    }
                    
                    if !paymentFormViewModel.isAmountValid {
                        ValidationErrorText(text: "Please enter a valid amount")
                    }
                    
                    if !paymentFormViewModel.isMemoValid {
                        ValidationErrorText(text: "Your memo should not exceed 300 characters")
                    }
                }
             
                // Name field
                FormTextField(name: "Name", placeHolder: "Enter your payment", value: $paymentFormViewModel.name)
                    .padding(.top)
                
                // Type selection
                VStack(alignment: .leading) {
                    Text("TYPE")
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.vertical, 10)
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            self.paymentFormViewModel.type = .income
                        }) {
                            Text("Income")
                                .font(.headline)
                                .foregroundColor(self.paymentFormViewModel.type == .income ? Color.white : Color.primary)
                        }
                        .frame(minWidth: 0.0, maxWidth: .infinity)
                        .padding()
                        .background(self.paymentFormViewModel.type == .income ? Color("IncomeCard") : Color(.systemBackground))
                        
                        Button(action: {
                            self.paymentFormViewModel.type = .expense
                        }) {
                            Text("Expense")
                                .font(.headline)
                                .foregroundColor(self.paymentFormViewModel.type == .expense ? Color.white : Color.primary)
                        }
                        .frame(minWidth: 0.0, maxWidth: .infinity)
                        .padding()
                        .background(self.paymentFormViewModel.type == .expense ? Color("ExpenseCard") : Color(.systemBackground))
                    }
                    .border(Color("Border"), width: 1.0)
                }
                
                // Date and Amount
                HStack {
                    FormDateField(name: "Date", value: $paymentFormViewModel.date)
                    
                    FormTextField(name: "Amount ($)", placeHolder: "0.0", value: $paymentFormViewModel.amount)
                }
                .padding(.top)
                
                // Location
                FormTextField(name: "Location (Optional)", placeHolder: "Where do you spend?", value: $paymentFormViewModel.location)
                    .padding(.top)
                
                // Memo
                FormTextEditor(name: "Memo (Optional)", value: $paymentFormViewModel.memo)
                    .padding(.top)
                
                
                // Save button
                Button(action: {
                    self.save()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .opacity(paymentFormViewModel.isFormInputValid ? 1.0 : 0.5)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("IncomeCard"))
                        .cornerRadius(10)
                        
                }
                .padding()
                .disabled(!paymentFormViewModel.isFormInputValid)
                
            }
            .padding()
        }
        .keyboardAdaptive()
        
    }
    
    // Save the record using Core Data
    private func save() {
        let newPayment = payment ?? PaymentActivity(context: context)
        
        newPayment.paymentId = UUID()
        newPayment.name = paymentFormViewModel.name
        newPayment.type = paymentFormViewModel.type
        newPayment.date = paymentFormViewModel.date
        newPayment.amount = Double(paymentFormViewModel.amount)!
        newPayment.address = paymentFormViewModel.location
        newPayment.memo = paymentFormViewModel.memo
        
        do {
            try context.save()
        } catch {
            print("Failed to save the record...")
            print(error.localizedDescription)
        }
    }
}

struct PaymentFormView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = PersistenceController.shared.container.viewContext
        
        let testTrans = PaymentActivity(context: context)
        testTrans.paymentId = UUID()
        testTrans.name = ""
        testTrans.amount = 0.0
        testTrans.date = .today
        testTrans.type = .expense
        
        return Group {
            PaymentFormView(payment: testTrans)
            PaymentFormView(payment: testTrans)
                .preferredColorScheme(.dark)
            
            FormTextField(name: "NAME", placeHolder: "Enter your payment", value: .constant("")).previewLayout(.sizeThatFits)
            
            ValidationErrorText(text: "Please enter the payment name").previewLayout(.sizeThatFits)

        }
    }
}

struct FormTextField: View {
    let name: String
    var placeHolder: String
    
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name.uppercased())
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            TextField(placeHolder, text: $value)
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
                .border(Color("Border"), width: 1.0)
         
        }
    }
}

struct FormDateField: View {
    let name: String
    
    @Binding var value: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name.uppercased())
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            DatePicker("", selection: $value, displayedComponents: .date)
                .accentColor(.primary)
                .padding(10)
                .border(Color("Border"), width: 1.0)
                .labelsHidden()
        }
    }
}

struct FormTextEditor: View {
    let name: String
    var height: CGFloat = 80.0
    
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name.uppercased())
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            TextEditor(text: $value)
                .frame(minHeight: height)
                .font(.headline)
                .foregroundColor(.primary)
                .padding()
                .border(Color("Border"), width: 1.0)
        }
    }
}


struct ValidationErrorText: View {

    var iconName = "info.circle"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)

    var text = ""
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}
