//
//  AddNewDestinationView.swift
//  Marco
//
//  Created by Jinming Liang on 6/8/23.
//

import SwiftUI

struct AddNewDestinationView: View {
    
    
    var prevDestination: Destination?;
    
    @State var destinationName: String = "";
    @State private var date: Date = Date()

    @State private var selectedDay = 1;
    @Binding var showAddNewDestinationView: Bool;
    @Binding var destinations: [Destination];
    
    let calendar = Calendar.current
    
    
    
    
    //Core Data stuff
    
    //currItinerary - the itinerary we will add the new destination to.
    var currItinerary: Itinerary;
        
    //using this context we will create the new Destination objects.
    @Environment (\.managedObjectContext) var viewContext
    
    func getDate() -> Date {
        if let prevDestination = prevDestination{
            // Assuming durationOfStay is Int or can be converted to Int
            return calendar.date(byAdding: .day, value: Int(self.selectedDay) + 1, to: prevDestination.startDate!) ?? Date()
        } else {
            return currItinerary.startDate ?? Date()
        }
    }

    
    func addDestination() async {
        let geocoder = GeoCoder()
        do {
            if let coordinates = try await geocoder.getCoordinates(address: self.destinationName) {
                let longitude = coordinates.longitude
                let latitude = coordinates.latitude
                
                let newDestination = Destination(context: viewContext)
                
                newDestination.destinationName = self.destinationName;
                newDestination.durationOfStay = Int64(self.selectedDay)
                
                // Set latitude and longitude to newDestination
                newDestination.latitude = latitude
                newDestination.longitude = longitude
                
                newDestination.startDate = getDate()
                
                currItinerary.addToDestinations(newDestination)
                
                
                
                do {
                    try await viewContext.save()
                    self.destinations.append(newDestination)
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        } catch {
            print("Geocoding error: \(error)")
        }
    }

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                TextField("Enter destination name", text: $destinationName)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                Text("How many days will you stay?")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Picker(selection: $selectedDay, label: Text("Number of Days")) {
                    ForEach(1..<31) { day in
                        Text("\(day)")
                    }
                }
                .pickerStyle(.wheel)
                .labelsHidden() // Hide labels
                .clipped()
                
                Spacer()
                
                Button(action: {
                    print("Destination added")
                    Task{
                        await self.addDestination()
                    }
                    
                    showAddNewDestinationView.toggle()
                }) {
                    Text("Add Destination")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
            .padding()
            .navigationBarTitle("Add New Destination", displayMode: .inline)
            .navigationBarItems(leading: Button("Back", action:{ showAddNewDestinationView.toggle()}))
            .onAppear {
                date = prevDestination == nil ? currItinerary.startDate! : Calendar.current.date(byAdding: .day, value: Int(prevDestination!.durationOfStay), to: prevDestination!.startDate!)!
                    }
        }
    }
}


//struct AddNewDestinationView_Previews: PreviewProvider {
//    static var previews: some View {
//        let exampleItinerary = Itinerary(context: PersistenceController.preview.container.viewContext)
//        exampleItinerary.startDate = Date()
//        
//        return AddNewDestinationView(
//            prevDestination: nil,
//            showAddNewDestinationView: .constant(true),
//            destinations: [], currItinerary: exampleItinerary
//            
//        )
//    }
//}


