import SwiftUI

struct CollapsibleSectionView<Content: View>: View {
    @State private var isExpanded: Bool = true
    var title: String
    var action: () -> Void
    let content: Content

    init(title: String, action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.title = title
        self.action = action
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: toggleExpansion) {
                HStack {
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                        .font(.title)
                        .foregroundColor(.blue)
                    Text("\(title)")
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
                .padding(.bottom)
            }
            .padding(.horizontal)
            if isExpanded {
                content
                    .padding(.horizontal)
            }
        }
    }

    func toggleExpansion() {
        isExpanded.toggle()
    }
}

struct CollapsibleSectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollapsibleSectionView(title: "Hotels", action: {}) {
            // Pass in the view you want to display here
            Text("This is some sample text")
        }
    }
}
