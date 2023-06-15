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
    
    let minDate = Calendar.current.date(byAdding: .year, value: -70, to: Date())!
    let maxDate = Calendar.current.date(byAdding: .year, value: 70, to: Date())!

    
    @Environment(\.managedObjectContext) private var viewContext

    private func addItem() {
        withAnimation {
            let newItinerary = Itinerary(context: viewContext)
            newItinerary.tripName = self.tripName
            newItinerary.startDate = self.startDate
            newItinerary.endDate = self.endDate
            newItinerary.startingPoint = self.startingPoint
            if let budgetInt = Int(self.budget) {
                newItinerary.budget = Int64(budgetInt);
            } else {
                newItinerary.budget = -1;
            }

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    var body: some View {
        
        VStack {
            HStack{
                Button(action: {
                    self.createNewItinerary = false}) {
                    Text("Back")
                }
                Spacer()
            }.padding(.leading)
            
            List{
                Section("Name of trip", content: {TextField("", text: $tripName)});
                
                Section("Please enter starting point", content: {TextField("", text: $startingPoint)});
                
                Section("What date will your trip start?",
                        content: {
                    DatePicker("", selection: $startDate, in: minDate...maxDate, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                });

                Section("What date will your trip end?",
                        content:{
                    DatePicker("", selection: $endDate, in: minDate...maxDate, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
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
                    
                    self.addItem()
                    
                    // dismiss the add itinerary view
                    self.createNewItinerary.toggle()
                }, label: {
                    HStack {
                        Spacer()
                        Text("Submit")
                        Spacer()
                    }
                })

            }.onChange(of: startDate, perform: {newValue in
                if newValue >= endDate{
                    endDate = newValue
                }
                
            })
            .onChange(of: endDate, perform: {newValue in
                if newValue <= startDate{
                    startDate = newValue
                }
            })
        }
    }
}



struct CreateNewItinerary_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewItinerary(createNewItinerary: .constant(false))
    }
}
