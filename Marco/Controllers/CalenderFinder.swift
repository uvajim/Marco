//
//  CalenderFinder.swift
//  Marco
//
//  Created by Jinming Liang on 6/7/23.
//

import Foundation
import UIKit


let colors: [UIColor] = [
    .black,
    .blue,
    .brown,
    .cyan,
    .darkGray,
    .gray,
    .green,
    .lightGray,
    .magenta,
    .orange,
    .purple,
    .red,
    .yellow
]

class MyEventDatabase: NSObject, UICalendarViewDelegate{
    
    
    
    var destinations: [Destination] = []
    
    var destinationColors = [colors.randomElement(), colors.randomElement(), colors.randomElement()]
    
    
    func updateDestinationColors(){
        
        while destinations.count > destinationColors.count{
            self.destinationColors.append(colors.randomElement())
        }
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            
        var i = 0;
        
        
        while i < destinations.count{
            // Declares the variables from the currDestination
            let currStartDate = destinations[i].startDate
            let currDuration = destinations[i].durationOfStay
                
            // Calculates the end dates
            let calendar = Calendar.current
            let endDate = calendar.date(byAdding: .day, value: Int(currDuration), to: currStartDate!)
            
            // Declares the random color for the current destination
            
            if let date = calendar.date(from: dateComponents) {
                print("Checking.... \(date)")
                    
                var currDate = currStartDate!
                    
                while currDate <= endDate! {
                    if calendar.isDate(currDate, inSameDayAs: date) {
                        return .default(color: destinationColors[i], size: .large)
                    }
                    currDate = calendar.date(byAdding: .day, value: 1, to: currDate)!
                }
            }
                
            i += 1
            print("curr i value: \(i)")
        }
                
        return nil
    }


}
