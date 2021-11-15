//
//  ToDoListDataManager.swift
//  ToDoList
//
//  Created by Hiba on 7/17/21.
//

import Foundation

class ToDoListDataManager {
    var userDefault: UserDefaults
    init(_ userDefault: UserDefaults = UserDefaults.standard) {
        self.userDefault = userDefault
    }
    
    func saveData(_ items: [ToDoListModel]) {
        do {
            let data = try JSONEncoder().encode(items)
            userDefault.setValue(data, forKey: "ToDoItems")
        } catch {
            
        }
    }
    
    func getItems() -> [ToDoListModel] {
        
        guard let items: Data = userDefault.data(forKey: "ToDoItems") else {
            return []
        }
        do {
            let decodedData = try JSONDecoder().decode([ToDoListModel].self, from: items)
            return decodedData
        } catch {
            return []
        }
    }
}
