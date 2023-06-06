//
//  ItineraryItem.swift
//  Marco
//
//  Created by Jinming Liang on 5/31/23.
//

import SwiftUI

let pictures = [
    "Tokyo Trip": "tokyo",
    "Patagonia Trip": "patagonia",
    "Marrakesh Getaway": "marrakesh"
]



struct ItineraryItem: View {
    
    
 
    
    var itinerary: String;
    
    init(itinerary: String) {
        self.itinerary = itinerary
    }
    
    
    
    var body: some View {
        VStack{
            switch itinerary{
            case "Tokyo Trip":
                Image("tokyo")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            case "Patagonia Trip":
                Image("patagonia")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            case "Marrakesh Getaway":
                Image("marrakesh")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            default:
                Text("No picture found")
            }
            Text(itinerary)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
        }
           
    }
}

struct ItineraryItem_Previews: PreviewProvider {
    static var previews: some View {
        
        ItineraryItem(itinerary: "Tokyo Trip")
    }
}
