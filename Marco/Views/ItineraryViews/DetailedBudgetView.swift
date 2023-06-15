import SwiftUI

struct BudgetLineView: View {
    var iconName: String
    var iconColor: Color
    var category: String
    var total: Int64

    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .foregroundColor(iconColor)
                    .frame(width: 40, height: 40)
                    .cornerRadius(3)
                
                Image(systemName: iconName)
                    .foregroundColor(.white)
            }
            Text("\(category): $\(total)")
        }
    }
}


struct DetailedBudgetView: View {
    @Environment (\.managedObjectContext) var viewContext
    @ObservedObject var currItinerary: Itinerary
    @State var changeBudget:Bool = false
    
    var totalBudget: Double {
        return Double(currItinerary.budget)
    }
    var transportationSpend: Double{
        return Double(currItinerary.transportationSpend)
    }
    var lodgingSpend: Double{
        return Double(currItinerary.lodgingSpend)
    }
    var foodSpend: Double{
        return Double(currItinerary.foodSpend)
    }
    var entertainmentSpend: Double{
        return Double(currItinerary.entertainmentSpend)
    }
    var miscSpend: Double{
        return Double(currItinerary.miscSpend)
    }
    
    var body: some View {
        VStack {
            SectionTitleView(title: "Budget Breakdown", action: {
                changeBudget.toggle()
            }, icon: "pencil.circle.fill")
            Spacer()
            GeometryReader { geometry in
                let radius = min(geometry.size.width, geometry.size.height) / 2
                let pieChartCenter = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                
                
                Path { path in
                    let travelEndAngle = Angle(degrees: (transportationSpend / totalBudget) * 360 - 90)
                    path.move(to: pieChartCenter)
                    path.addArc(center: pieChartCenter, radius: radius, startAngle: Angle(degrees: -90), endAngle: travelEndAngle, clockwise: false)
                }
                .fill(Color.red)
                
                Path { path in
                    let lodgingEndAngle = Angle(degrees: ((transportationSpend + lodgingSpend) / totalBudget) * 360 - 90)
                    path.move(to: pieChartCenter)
                    path.addArc(center: pieChartCenter, radius: radius, startAngle: Angle(degrees: (transportationSpend / totalBudget) * 360 - 90), endAngle: lodgingEndAngle, clockwise: false)
                }
                .fill(Color.blue)
                
                Path { path in
                    let foodEndAngle = Angle(degrees: ((transportationSpend + lodgingSpend + foodSpend) / totalBudget) * 360 - 90)
                    path.move(to: pieChartCenter)
                    path.addArc(center: pieChartCenter, radius: radius, startAngle: Angle(degrees: ((transportationSpend + lodgingSpend) / totalBudget) * 360 - 90), endAngle: foodEndAngle, clockwise: false)
                }
                .fill(Color.green)
                
                Path { path in
                    let entertainmentEndAngle = Angle(degrees: ((transportationSpend + lodgingSpend + foodSpend + entertainmentSpend) / totalBudget) * 360 - 90)
                    path.move(to: pieChartCenter)
                    path.addArc(center: pieChartCenter, radius: radius, startAngle: Angle(degrees: ((transportationSpend + lodgingSpend + foodSpend) / totalBudget) * 360 - 90), endAngle: entertainmentEndAngle, clockwise: false)
                }
                .fill(Color.yellow)
                
                Path { path in
                    let miscEndAngle = Angle(degrees: ((transportationSpend + lodgingSpend + foodSpend + entertainmentSpend + miscSpend) / totalBudget) * 360 - 90)
                    path.move(to: pieChartCenter)
                    path.addArc(center: pieChartCenter, radius: radius, startAngle: Angle(degrees: ((transportationSpend + lodgingSpend + foodSpend + entertainmentSpend) / totalBudget) * 360 - 90), endAngle: miscEndAngle, clockwise: false)
                }
                .fill(Color.pink)
                
                Path { path in
                    let remainingStartAngle = Angle(degrees: ((transportationSpend + lodgingSpend + foodSpend + entertainmentSpend + miscSpend) / totalBudget) * 360 - 90)
                    path.move(to: pieChartCenter)
                    path.addArc(center: pieChartCenter, radius: radius, startAngle: remainingStartAngle, endAngle: Angle(degrees: 270), clockwise: false)
                }
                .fill(Color.purple)
            }
            .padding(.vertical)
            List{
                BudgetLineView(iconName: "star.fill", iconColor: .yellow, category: "Entertainment", total: Int64(entertainmentSpend))
                BudgetLineView(iconName: "airplane.departure", iconColor: .red, category: "Transportation", total: Int64(transportationSpend))
                BudgetLineView(iconName: "house.fill", iconColor: .blue, category: "Lodging", total: Int64(lodgingSpend))
                BudgetLineView(iconName: "fork.knife", iconColor: .green, category: "Food", total: Int64(foodSpend))
                BudgetLineView(iconName: "balloon.fill", iconColor: .pink, category: "Misc", total: Int64(miscSpend))
                BudgetLineView(iconName: "banknote", iconColor: .purple, category: "Remaining Budget", total: Int64(totalBudget - entertainmentSpend - transportationSpend - lodgingSpend - foodSpend - miscSpend))
            }
            .listStyle(.plain)
           
        }.fullScreenCover(isPresented: $changeBudget, content: {SetBudgetView(changeBudget: $changeBudget, currItinerary: currItinerary).environment(\.managedObjectContext, viewContext)})
    }
}


struct DetailedBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        let testItinerary = Itinerary()
        
        DetailedBudgetView(currItinerary: testItinerary)
    }
}
                                                            
