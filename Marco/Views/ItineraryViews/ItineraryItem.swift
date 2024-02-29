//
//  ItineraryItem.swift
//  Marco
//
//  Created by Jinming Liang on 5/31/23.
//

import SwiftUI

import UIKit

let pictures = [
    "Tokyo Trip": "tokyo",
    "Patagonia Trip": "patagonia",
    "Marrakesh Getaway": "marrakesh"
]

extension UIImage {
    static func imageWith(text: String, fontSize: CGFloat = 16, imageSize: CGSize = CGSize(width: 100, height: 100)) -> UIImage? {
        // Start a graphics context
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        
        // Draw the text
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: UIColor.black
        ]
        
        let string = NSString(string: text)
        let rect = CGRect(origin: .zero, size: imageSize)
        string.draw(in: rect, withAttributes: attributes)
        
        // Capture the image and end the context
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}



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
                if let uiImage = UIImage.imageWith(text: itinerary) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                }
            }
            Text(itinerary)
                .font(.largeTitle)
                .bold()
        }
           
    }
}

struct ItineraryItem_Previews: PreviewProvider {
    static var previews: some View {
        
        ItineraryItem(itinerary: "Tokyo Trip")
    }
}
