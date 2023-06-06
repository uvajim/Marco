//
//  CreateNewItinerary.swift
//  Marco
//
//  Created by Jinming Liang on 5/31/23.
//

import SwiftUI

struct CreateNewItinerary: View {
    @State var tripName = "";
    @State var startingPoint = "";
    @State var startDate = Date();
    @State var endDate = Date();
    @State var isBudget = false;
    @State var budget = "";
    @Binding var createNewItinerary: Bool;
    
    @Environment (\.managedObjectContext) var managedObjectContext
    
    
    
    
    
    func createItinerary() -> Void{
        
        
    }
    
    
    var body: some View {
        
        VStack {
            Button(action: {
                self.createNewItinerary = false
            }) {
                Text("Back")
            }
            List{
                Section("Name of trip", content: {TextField("", text: $tripName)});
                Section("Please enter starting point", content: {TextField("", text: $startingPoint)});
                Section("What date will your trip end?",
                        content: {DatePicker("", selection: $startDate,displayedComponents: [.date]).datePickerStyle(.graphical)});
                Section("What date will your trip start?",
                        content:{
                    DatePicker("",
                               selection: $endDate, in: startDate..., displayedComponents: [.date]).datePickerStyle(.graphical)
                });
                Section("Budget", content: {
                    Toggle("Would you like to add a budget?", isOn: $isBudget)
                        .toggleStyle(.switch);
                    if isBudget{
                        TextField("What is your budget?", text: $budget).keyboardType(.numberPad)
                            .transition(.scale(scale: 0.1).combined(with: .opacity))
                    }
                })
                

                Button(action: {
                    // add the new Itinerary to App Storage
                    
                    self.createItinerary()
                    
                    // dismiss the add itinerary view
                    self.createNewItinerary.toggle()

                    print("Name: \(tripName)")
                    print("Starting Point: \(startingPoint)")
                    print("Start Date: \(startDate)")
                    print("End Date: \(endDate)")
                    print("Budget")
                }, label: {
                    HStack {
                        Spacer()
                        Text("Submit")
                        Spacer()
                    }
                })

            }
        }
    }
}



struct CreateNewItinerary_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewItinerary(createNewItinerary: .constant(false))
    }
}
