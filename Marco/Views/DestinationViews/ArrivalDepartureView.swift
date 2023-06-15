import SwiftUI

struct ArrivalDepartureView: View {
    @State private var selectedArrivalIndex: Int = -1
    @State private var selectedDepartureIndex: Int = -1
    @State private var isViewVisible = true
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var currDestination: Destination

    let methods = ["airplane", "car.fill", "tram.fill"]

    var body: some View {
        VStack {
            if isViewVisible {
                VStack(alignment: .leading) {
                    Text("Arriving via")
                        .font(.headline)

                    HStack {
                        ForEach(0..<methods.count) { index in
                            Image(systemName: methods[index])
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: index == (currDestination.arrivalMethod) ? 2 : 0)
                                )
                                .onTapGesture {
                                    saveArrivalMethod(index: index)
                                    
                                }
                                .foregroundColor(index == selectedArrivalIndex ? .blue : .gray)
                        }
                    }
                    .padding(.bottom, 20)

                    Text("Departing via")
                        .font(.headline)

                    HStack {
                        ForEach(0..<methods.count) { index in
                            Image(systemName: methods[index])
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: index == currDestination.departureMethod ? 2 : 0)
                                )
                                .onTapGesture {
                                    saveDepartureMethod(index: index)
                                }
                                .foregroundColor(index == selectedDepartureIndex ? .blue : .gray)
                        }
                    }
                }
                .padding()
                .animation(.easeInOut)
            }
            
            Spacer()
        }
    }
    
    
    //Core Data fucntions
    
    //Look at function name
    func saveArrivalMethod(index: Int){
        self.currDestination.arrivalMethod = Int64(index)
        do{
            try viewContext.save()
        }
        catch{
            print("Failed to save arrival method")
        }
    }
    
    //Same here
    func saveDepartureMethod(index: Int){
        
        self.currDestination.departureMethod = Int64(index)
        do{
            try viewContext.save()
        }
        catch{
            print("Failed to save departure method")
        }
    }
}

struct ArrivalDepartureView_Previews: PreviewProvider {
    static var previews: some View {
        var testDestination = Destination()
        ArrivalDepartureView(currDestination: testDestination)
    }
}
