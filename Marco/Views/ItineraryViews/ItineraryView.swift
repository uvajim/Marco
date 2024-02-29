import Foundation
import SwiftUI
import MapKit

struct ItineraryView: View {
    var budget = 1000
    var currItinerary: Itinerary;
    
    
    
    @Environment (\.managedObjectContext) var viewContext
    
    //the time for
    var year: Int? {
        let calendar = Calendar.current
        return calendar.component(.year, from: currItinerary.startDate!)
    }
    
    var month: Int? {
        let calendar = Calendar.current
        return calendar.component(.month, from: currItinerary.startDate!)
    }
    
    var day: Int? {
        let calendar = Calendar.current
        return calendar.component(.day, from: currItinerary.startDate!)
    }
    
    let mapViewModel = MapViewModel(latitude: 37.7749, longitude: -122.4194) // Coordinates for San Francisco
    
    
    @State var showAddNewDestinationView = false;
    @State var showSetBudgetView = false;
    @State var editDates = false;
    @State private var destinations: [Destination] = []
    
    
    
    var body: some View {
        
        

        let mostRecentDestionation = destinations.last
        
        
        
        VStack{
            List{
                //Destination Section
                Section(header: SectionTitleView(title: "Destinations", action: {
                    self.showAddNewDestinationView.toggle()
                }),  content: {
                    ForEach(0..<max(0, destinations.count), id:\.self){ i in
                        NavigationLink(destination: DestinationView(destinations: destinations, currLocation: i).environment(\.managedObjectContext, viewContext) ) {
                            Text(destinations[i].destinationName ?? "")
                            
                        }
                    }
                    .onMove(perform: moveItem)
                    .onDelete(perform: deleteDestination)
                })
                
                //Dates desction
//                Section(header: SectionTitleView(title: "Dates", action: {
//                    self.editDates.toggle()
//                }, icon: "pencil.circle.fill"), content: {
//                    NavigationLink(destination: CalendarRepresentableView(year: self.year!, month: self.month!, day: self.day!, destinations: destinations)) {
//                        Text("\(DateInterval(start: currItinerary.startDate!, end: currItinerary.endDate!))")
//                    }
//                })
                
                //Budget Section
                Section(header: SectionTitleView(title: "Budget", action: {
                    self.showSetBudgetView.toggle()
                }, icon: "pencil.circle.fill"), content: {
                    if currItinerary.budget > 0{
                        NavigationLink(destination: DetailedBudgetView(currItinerary: self.currItinerary)) {
                            BudgetView(currItinerary: currItinerary
                            )
                        }
                    }
                    else{
                        Text("There is no set budget for this trip")
                        
                    }
                    
                })
                
            }.fullScreenCover(isPresented: $showAddNewDestinationView, content: {AddNewDestinationView(prevDestination: destinations.last, showAddNewDestinationView: $showAddNewDestinationView, destinations: $destinations, currItinerary: self.currItinerary)})
                .fullScreenCover(isPresented: $editDates, content: {
                    EditDatesView(currItinerary: self.currItinerary, newStartDate: self.currItinerary.startDate!, newEndDate: self.currItinerary.endDate!, showUpdateDateView: $editDates)
                })
                .fullScreenCover(isPresented: $showSetBudgetView, content: {
                    SetBudgetView(changeBudget: $showSetBudgetView, currItinerary: self.currItinerary)
                })
                
        }.onAppear{
            updateDestinations()
        }
        
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        destinations.move(fromOffsets: source, toOffset: destination)
        }
    
    private func updateDestinations() {
            destinations = (currItinerary.destinations as? Set<Destination>)?.sorted(by: {
                ($0.startDate ?? Date()) < ($1.startDate ?? Date())
            }) ?? []
        }
    
    private func deleteDestination(at offsets: IndexSet) {
        offsets.forEach { index in
            let sortedDestinations = (currItinerary.destinations as? Set<Destination>)?.sorted(by: { ($0.startDate ?? Date()) < ($1.startDate ?? Date()) }) ??
            []
            if index < sortedDestinations.count {
                let destination = sortedDestinations[index]
                currItinerary.removeFromDestinations(destination)
                viewContext.delete(destination)
            }
        }
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }


}




struct ItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = PersistenceController.preview.container.viewContext
        
        let currItinerary = Itinerary(context: context)
        
        return ItineraryView(currItinerary: currItinerary) // Pass a valid instance of Itinerary
    }
}

