//
//  HomeView.swift
//  Marco
//
//  Created by Jinming Liang on 6/5/23.
//

import SwiftUI

struct HomeView: View {
    
    let testIinerary = ["Tokyo Trip", "Patagonia Trip", "Marrakesh Getaway"]
    
    @Environment (\.managedObjectContext) var managedObjectContext
    
    @State var createNewItinerary = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(testIinerary, id: \.self){ itinerary in
                    NavigationLink{
                        ContentView()
                    } label: {
                        ItineraryItem(itinerary: itinerary)
                    }
                }.navigationTitle("Itineraries")
            }
            .listStyle(.plain)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        createNewItinerary.toggle()
                    }, label: {Image(systemName: "rectangle.and.pencil.and.ellipsis")})
                })
            }
        }.fullScreenCover(isPresented: $createNewItinerary, onDismiss: {}, content: {CreateNewItinerary(createNewItinerary: $createNewItinerary)
                .environment(\.managedObjectContext, self.managedObjectContext)
        } )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
