//
//  BudgetView.swift
//  Marco
//
//  Created by Jinming Liang on 6/6/23.
//

import SwiftUI

struct BudgetView: View {
    @State var currItinerary: Itinerary;
    @Environment (\.managedObjectContext) var viewContext
    
    
    var totalBudget: Int {
        return Int(currItinerary.budget)
    }
    var currentSpend: Int {
        return Int(currItinerary.foodSpend + currItinerary.transportationSpend + currItinerary.lodgingSpend
                   + currItinerary.entertainmentSpend + currItinerary.miscSpend)
    }

    var body: some View {
            VStack{
                GeometryReader { geometry in
                    let totalWidth = geometry.size.width
                    let spentWidth = CGFloat(currentSpend) / CGFloat(totalBudget) * totalWidth

                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: totalWidth, height: 20)
                            .opacity(0.3)
                            .foregroundColor(.blue)

                        Rectangle()
                            .frame(width: spentWidth, height: 20)
                            .foregroundColor(.blue)
                    }
                }
                .frame(height: 20)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Text("You have $\(currItinerary.budget) left for this trip")
            }
    }
}


struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {

                let sampleItinerary = Itinerary()
                sampleItinerary.budget = 5000

                return BudgetView(currItinerary: sampleItinerary)
                    
    }
}
