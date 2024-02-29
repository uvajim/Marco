//
//  NewToDoList.swift
//  Marco
//
//  Created by Jinming Liang on 6/7/23.
//

import SwiftUI

struct NewToDoItem: View {
    
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var newToDoItem: String = "";
    var currDestination: Destination;
    @Binding var createNewToDo: Bool;
    @FocusState private var focusedField: Bool
    
    var body: some View {
        HStack{
            Image(systemName: "circle")
                .resizable()
                .frame(width: 24, height: 24)
            TextField("", text: $newToDoItem)
                .focused($focusedField)
                
                .textFieldStyle(.roundedBorder)
            Button(action: {
                self.addToDo()
                createNewToDo = false
            }, label: {Image(systemName: "plus.app.fill")})
        }
        .padding(.trailing)
        .padding(.leading)
        
    }

    
    
    func addToDo(){
        //add
        
        let newToDo = ChecklistItem(context: viewContext)
        
        newToDo.listItem = self.newToDoItem
        currDestination.addToTodo(newToDo)
        
        do {
            
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}

struct NewToDoItem_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        
        let exampleDestination = Destination(context: context)
        
        return NewToDoItem(currDestination: exampleDestination, createNewToDo: .constant(false))
            .environment(\.managedObjectContext, context)
    }
}

