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
    @State var editDates = false;
    
    
    
    var body: some View {
        
        let destinations = (currItinerary.destinations as? Set<Destination>)?.sorted(by: { ($0.startDate ?? Date()) < ($1.startDate ?? Date()) }) ?? []

        let mostRecentDestionation = destinations.last
        
        
        
        VStack{
            List{
                //Destination Section
                Section(header: SectionTitleView(title: "Destinations", action: {
                    self.showAddNewDestinationView.toggle()
                }),  content: {
                    ForEach(destinations, id: \.self){ destination in
                        NavigationLink(destination: DestinationView(destination: destination).environment(\.managedObjectContext, viewContext) ) {
                            Text(destination.destinationName ?? "")
                        }
                    }.onDelete(perform: deleteDestination)
                })
                
                //Dates desction
                Section(header: SectionTitleView(title: "Dates", action: {
                    self.editDates.toggle()
                }, icon: "pencil.circle.fill"), content: {
                    NavigationLink(destination: CalendarRepresentableView(year: self.year!, month: self.month!, day: self.day!, destinations: destinations)) {
                        Text("\(DateInterval(start: currItinerary.startDate!, end: currItinerary.endDate!))")
                    }
                })
                
                //Budget Section
                Section(header: SectionTitleView(title: "Budget", action: {
                    
                }, icon: "pencil"), content: {
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
                
            }.fullScreenCover(isPresented: $showAddNewDestinationView, content: {AddNewDestinationView(prevDestination: destinations.last, showAddNewDestinationView: $showAddNewDestinationView, currItinerary: self.currItinerary)})
                .fullScreenCover(isPresented: $editDates, content: {
                    EditDatesView(currItinerary: self.currItinerary, newStartDate: self.currItinerary.startDate!, newEndDate: self.currItinerary.endDate!, showUpdateDateView: $editDates)
                })
        }
        
    }
    
    private func deleteDestination(at offsets: IndexSet) {
        offsets.forEach { index in
            let sortedDestinations = (currItinerary.destinations as? Set<Destination>)?.sorted(by: { ($0.destinationName ?? "") < ($1.destinationName ?? "") }) ??
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
        Text("Placeholder") // ItineraryView() with a sample instance
        //ItineraryView(currItinerary: Itinerary())
    }
}
