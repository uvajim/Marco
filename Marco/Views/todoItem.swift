//
//  todoItem.swift
//  Marco
//
//  Created by Jinming Liang on 6/5/23.
//

import SwiftUI

struct todoItem: View {
    @State var isChecked: Bool = false
    var todo: String

        var body: some View {
            HStack{
                Button(action: {
                    isChecked.toggle()
                }) {
                    Image(systemName: isChecked ? "circle.fill" : "circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                Text("\(todo)")
            }
           
            }
            
    }

struct todoItem_Previews: PreviewProvider {
    static var previews: some View {
        todoItem(todo: "Museums")
    }
}
