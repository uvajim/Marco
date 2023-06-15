//
//  ToDoView.swift
//  Marco
//
//  Created by Jinming Liang on 6/6/23.
//

import SwiftUI
import CoreData

struct todoItem: View {
    
    @ObservedObject var todo: ChecklistItem
    @Environment(\.managedObjectContext) private var viewContext
    
    
    
    var body: some View {
        HStack{
            Button(action: {
                toggleButton()
            }) {
                Image(systemName: todo.completed ? "circle.fill" : "circle")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            Text(todo.listItem!)
            Spacer()
        }
        .padding(.leading)
        .padding(.trailing)
        
    }
    
    func toggleButton(){
        todo.completed = !todo.completed
        do{
            try viewContext.save()
        }
        catch{
            print("error toggling the completed field")
        }
    }
    
}

struct ToDoView: View {
    
    enum Field{
        case newToDo
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var currDestination: Destination;
    
    @State var createToDo = false
    @State var newToDoName = ""
    
    @FocusState var newToDo: Field?
    
    var body: some View {
        
        let todoItems = Array((currDestination.todo as? Set<ChecklistItem>) ?? [])
        
        CollapsibleSectionView(title: "To Do", action: {
            createToDo.toggle()
        }, content: {
            ScrollView{
                if createToDo{
                    NewToDoItem(currDestination: currDestination,  createNewToDo: $createToDo).environment(\.managedObjectContext, viewContext)
                        .focused($newToDo, equals: .newToDo)
                        .padding(.top)
                }

                ForEach(todoItems, id: \.self) { item in
                    todoItem(todo: item).environment(\.managedObjectContext, viewContext)
                        .padding(.bottom)
                        .padding(.top)
                }
                                
            }
            .padding(.leading)
        })

    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        let testDestination = Destination()
        
        ToDoView(currDestination: testDestination)
    }
}
