import SwiftUI

struct SwiftView: View {
    
    var title: String;
    var action: () -> Any;
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Section Title")
                    .font(.title)
                    .bold()

                Spacer()

                Button(action: {
                    // Your add action goes here
                    action()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SwiftView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        SwiftView(title: "Hotels", action: {})
    }
}

