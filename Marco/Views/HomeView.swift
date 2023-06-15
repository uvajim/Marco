//
//  HomeView.swift
//  Marco
//
//  Created by Jinming Liang on 6/5/23.
//
//  This 
//

import SwiftUI

struct HomeView: View {

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Itinerary.startDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Itinerary>
    
    
    @Environment (\.managedObjectContext) var viewContext
    
    @State var createNewItinerary = false
    
    
    private func deleteItems(at offsets: IndexSet) {
           for index in offsets {
               let item = items[index]
               viewContext.delete(item)
           }
           
           do {
               try viewContext.save()
           } catch {
               // handle the Core Data error
           }
       }
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(items){ item in
                    NavigationLink{
                        ItineraryView(currItinerary: item).environment(\.managedObjectContext, self.viewContext)
                    } label: {
                        ItineraryItem(itinerary: item.tripName!)
                    }
                }
                .onDelete(perform: deleteItems)
                .navigationTitle("Itineraries")
                
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
                .environment(\.managedObjectContext, self.viewContext)
        } )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
