import SwiftUI
import MapKit
import CoreData

struct DestinationView: View {
    
    enum Field: Hashable {
            case newToDoItem
        }
    
    
    @ObservedObject var mapModel: MapViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @State var destinations: [Destination];
    
    
    @State var currLocation: Int
    
    init(destinations: [Destination], currLocation: Int) {
        
        self.destinations = destinations
        self.currLocation = currLocation
        self.mapModel = MapViewModel(latitude: destinations[currLocation].latitude, longitude: destinations[currLocation].longitude)
        
    }
    
    
    
    var body: some View {
        
        
        
        VStack {
            VStack {
                Text(destinations[currLocation].destinationName ?? "")
                    .font(.largeTitle).bold()
                Text("\(destinations[currLocation].startDate ?? Date())")
                    .font(.headline)
            }
            .padding(.bottom)
            
            ScrollView {
                ZStack {
                    Map(coordinateRegion: $mapModel.region)
                        .frame(height: 300)
                        .cornerRadius(20)
                    
                    if mapModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(1.5, anchor: .center)
                    }
                }
                .padding(.bottom)
                
                CollapsibleSectionView(title: "Travel Details", action: {}, content: {
                    ArrivalDepartureView(currDestination: self.destinations[currLocation])
                })
                
                CollapsibleSectionView(title: "Hotel", action: {
                    
                }, content: {
                    
                })
                
                
                ToDoView(currDestination: destinations[currLocation]).environment(\.managedObjectContext, self.viewContext)
                
                
                
            }.padding(.bottom)
            
            HStack {
                Button(action: {
                    if currLocation != 0{
                        self.currLocation = currLocation - 1
                        self.mapModel.updateCoordinates(latitude: destinations[currLocation].latitude, longitude: destinations[currLocation].longitude)
                    }
                    
                    
                    //viewModel.updateRegion(name: self.name)
                }) {
                    VStack {
                        Image(systemName: "chevron.left")
                        Text("Previous Destination")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                    }
                }.padding(.leading)
                Spacer()
                
                Button(action: {
                    if self.currLocation != destinations.count - 1{
                        self.currLocation = currLocation + 1
                        self.mapModel.updateCoordinates(latitude: destinations[currLocation].latitude, longitude: destinations[currLocation].longitude)
                    }
                    
                    //self.name = deestinations[currLocation]
                    //viewModel.updateRegion(name: self.name)
                }) {
                    VStack {
                        Image(systemName: "chevron.right")
                        Text("Next Destination")
                            .font(.footnote)
                    }
                    .padding(.trailing)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
    }
}

struct DestinationViewPreview: PreviewProvider {
    
    @State static var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    static var previews: some View {
        Map(coordinateRegion: $region)
            .frame(height: 300)
            .cornerRadius(20)
    }
}


