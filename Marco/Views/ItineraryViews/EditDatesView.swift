//
//  EditDatesView.swift
//  Marco
//
//  Created by Jinming Liang on 6/13/23.
//

import SwiftUI

struct EditDatesView: View {
    @ObservedObject var currItinerary: Itinerary
    @Binding var showUpdateDateView: Bool
    @State var newStartDate: Date
    @State var newEndDate: Date
    
    
    @Environment (\.managedObjectContext) var viewContext
    
    
    
    init(currItinerary: Itinerary, newStartDate: Date, newEndDate: Date, showUpdateDateView: Binding<Bool>) {
        self.currItinerary = currItinerary
        self._showUpdateDateView = showUpdateDateView
        _newStartDate = State(initialValue: currItinerary.startDate ?? Date())
        _newEndDate = State(initialValue: currItinerary.endDate ?? Date())
        
    }
    
    func updateDates(){
        self.currItinerary.startDate = newStartDate
        self.currItinerary.endDate = newEndDate
        do{
            try viewContext.save()
        }
        catch{
            print("error saving new dates")
        }
    }
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Text("Update Itinerary Dates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Start Date")
                    .font(.title3)
                    .padding(.leading)
                    .bold()
                DatePicker("Start Date", selection: $newStartDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                    .onChange(of: newStartDate, perform: { newValue in
                                        if newValue >= newEndDate {
                                            newEndDate = newValue
                                        }
                                    })
                Text("End Date")
                    .font(.title3)
                    .padding(.leading)
                    .bold()
                DatePicker("End Date", selection: $newEndDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                    .onChange(of: newEndDate, perform: { newValue in
                                        if newValue <= newStartDate {
                                            newStartDate = newValue
                                        }
                                    })
                    
                
                Button(action: {
                    self.updateDates()
                    self.showUpdateDateView.toggle()
                }) {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            
        }
    }
    
}

struct EditDatesView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let testItinerary = Itinerary(context: context)
        
        return EditDatesView(currItinerary: testItinerary, newStartDate: Date(), newEndDate: Date(), showUpdateDateView: .constant(true))
            .environment(\.managedObjectContext, context)
    }
}

