//
//  ItineraryView.swift
//  Marco
//
//  Created by Jinming Liang on 6/5/23.
//

import SwiftUI

struct ItineraryView: View {
    var budget = 1000
    
    var body: some View {
        VStack{
                List{
                    Section("Destinations", content: {
                        Text("Destination 1")
                        Text("Destination 2")
                        Text("Destination 3")
                    })
                    Section("Dates", content: {
                        Text(DateInterval(start: Date(), end: Date()))
                    })
                    Section("Budget", content: {
                        Text("You have $ \(budget) left")
                    })
                }
                
                
                Text("Dates")
                
                
            }
            
            
        }
    }

struct ItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        ItineraryView()
    }
}
