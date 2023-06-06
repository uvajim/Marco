import SwiftUI

struct DestinationView: View {
    // Here you can control the view to be shown
    @State private var selection = 0
    
    var body: some View {
        VStack {
            // This switch will show the appropriate view depending on selection
            switch selection {
            case 1:
                ItineraryView()
            case 2:
                Text("Previous destination")
            case 3:
                Text("Next destination")
            default:
                List {
                    Section("Hotel", content: {
                        Text("hotel will go here")
                    })
                    Section("Attractions", content: {
                        todoItem(todo:"Museum")
                        todoItem(todo:"Opera")
                        todoItem(todo:"Beach Day")
                    })
                }
            }

            // Custom tab bar
            HStack {
                            Spacer()
                            Button(action: { selection = 2 }) {
                                VStack {
                                    Image(systemName: "chevron.left")
                                    Text("Previous Destination")
                                        .font(.footnote)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            Spacer()
                            Button(action: { selection = 1 }) {
                                VStack {
                                    Image(systemName: "map")
                                    Text("Back to Itinerary")
                                        .font(.footnote)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            Spacer()
                            Button(action: { selection = 3 }) {
                                VStack {
                                    Image(systemName: "chevron.right")
                                    Text("Next Destination")
                                        .font(.footnote)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground)) // use system background color
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5) // add shadow for better separation
        }
    }
}

struct DestinationViewPreview: PreviewProvider{
    
    static var previews: some View{
        DestinationView()
    }
}
