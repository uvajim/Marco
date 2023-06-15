//
//  SetBudgetView.swift
//  Marco
//
//  Created by Jinming Liang on 6/12/23.
//

import SwiftUI


struct BudgetCategory: View{
    
    @Binding var category: String;
    var currItinerary: Itinerary;
    var currBudget: String?;
    
    @Environment (\.managedObjectContext) var viewContext;
    
    var body: some View{
        HStack{
            Text("$")
            TextField(currBudget ?? "Not set", text: $category)
                .keyboardType(.numberPad)
            Text("per day")
        }
    }
}



struct SetBudgetView: View {
    @State var transportationSpend = ""
    @State var foodSpend = ""
    @State var entertainmentSpend = ""
    @State var lodgingSpend = ""
    @State var miscSpend = ""
    
    @Binding var changeBudget: Bool;
    
    var currItinerary: Itinerary
    @Environment (\.managedObjectContext) var viewContext;
    
    //function that updates the itinerary's budget fields
    //paramters: none - relies instead on the variables
    func updateBudget(){
        currItinerary.transportationSpend = Int64(transportationSpend) ?? currItinerary.transportationSpend
        currItinerary.foodSpend = Int64(foodSpend) ?? currItinerary.foodSpend
        currItinerary.entertainmentSpend = Int64(entertainmentSpend) ?? currItinerary.entertainmentSpend
        currItinerary.lodgingSpend = Int64(lodgingSpend) ?? currItinerary.lodgingSpend
        currItinerary.miscSpend = Int64(miscSpend) ?? currItinerary.miscSpend
        
        do{
            try viewContext.save()
        }
        catch{
            print("error updating the budget")
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
            }.padding(.leading)
           
            Form{
                            Section("Lodging Budget", content: {
                                BudgetCategory(category: $lodgingSpend, currItinerary: self.currItinerary, currBudget: String(currItinerary.lodgingSpend))
                                    .environment(\.managedObjectContext, self.viewContext)
                            })
                            Section("Food Budget", content: {
                                BudgetCategory(category: $foodSpend, currItinerary: self.currItinerary, currBudget: String(currItinerary.foodSpend))
                                    .environment(\.managedObjectContext, self.viewContext)
                            })
                            Section("Entertainment Budget", content: {
                                BudgetCategory(category: $entertainmentSpend, currItinerary: self.currItinerary, currBudget: String(currItinerary.entertainmentSpend))
                                    .environment(\.managedObjectContext, self.viewContext)
                            })
                            Section("Transportation Budget", content: {
                                BudgetCategory(category: $transportationSpend, currItinerary: self.currItinerary, currBudget: String(currItinerary.transportationSpend))
                                    .environment(\.managedObjectContext, self.viewContext)
                            })
                            Section("Misc Budget", content: {
                                BudgetCategory(category: $miscSpend, currItinerary: self.currItinerary, currBudget: String(currItinerary.miscSpend))
                                    .environment(\.managedObjectContext, self.viewContext)
                            })
                        }.formStyle(.automatic)
            HStack{
                Spacer()
                Button("Done", action: {
                    self.updateBudget()
                    self.changeBudget.toggle()
                })
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
    }
}

struct SetBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        let testItinerary = Itinerary()
        SetBudgetView(changeBudget: .constant(true), currItinerary: testItinerary)
    }
}
