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
    
    @State private var currItinerary = ""
    @State private var count = 0
    
    
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
            TabView(selection:$currItinerary){
                ForEach(items){item in
                        ItineraryView(currItinerary: item).onAppear {
                            count += 1
                            print("Count: \(count)")
                        }
                    .tag(item.tripName!)
                }
            }.onAppear {
                if let firstItem = items.first {
                    currItinerary = firstItem.tripName!
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        createNewItinerary.toggle()
                    }, label: {Image(systemName: "rectangle.and.pencil.and.ellipsis")})
                })
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Text(currItinerary)
                        .font(.title)
                        .bold()
                        .padding(.all)
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
