import SwiftUI
import MapKit
import CoreData

struct DestinationView: View {
    
    enum Field: Hashable {
            case newToDoItem
        }
    
    
    @ObservedObject var viewModel: MapViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @State var destination: Destination;
    
    
    @State var currLocation = 1
    
    init(destination: Destination, currLocation: Int = 1) {
        
        self.destination = destination
        self.currLocation = currLocation
        print(destination.latitude)
        print(destination.longitude)
        self.viewModel = MapViewModel(latitude: destination.latitude, longitude: destination.longitude)
        
    }
    
    
    
    var body: some View {
        
        
        
        VStack {
            VStack {
                Text(destination.destinationName ?? "")
                    .font(.largeTitle).bold()
                Text("\(destination.startDate ?? Date())")
                    .font(.headline)
            }
            .padding(.bottom)
            
            ScrollView {
                ZStack {
                    Map(coordinateRegion: $viewModel.region)
                        .frame(height: 300)
                        .cornerRadius(20)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(1.5, anchor: .center)
                    }
                }
                .padding(.bottom)
                
                CollapsibleSectionView(title: "Travel Details", action: {}, content: {
                    ArrivalDepartureView(currDestination: self.destination)
                })
                
                CollapsibleSectionView(title: "Hotel", action: {
                    
                }, content: {
                    
                })
                
                
                ToDoView(currDestination: destination).environment(\.managedObjectContext, self.viewContext)
                
                
                
            }.padding(.bottom)
            
            HStack {
                Button(action: {
                    self.currLocation = currLocation - 1
                    //self.name = deestinations[currLocation]
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
                    self.currLocation = currLocation + 1
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


