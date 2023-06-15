import SwiftUI

struct SectionTitleView: View {
    
    var title: String;
    var action: () -> Void;
    var icon: String = "plus.circle.fill"
    
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            HStack {
                Text("\(title)")
                    .font(.title)
                    .bold()

                Spacer()

                Button(action: {
                    // Your add action goes here
                    action()
                }) {
                    Image(systemName: icon)
                        .font(.title)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SwiftView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        SectionTitleView(title: "Hotels", action: {})
    }
}

