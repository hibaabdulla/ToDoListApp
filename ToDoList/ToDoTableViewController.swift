//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Hiba on 7/17/21.
//

import UIKit

class ToDoTableViewController: UIViewController,
                               UITableViewDataSource,
                               UITableViewDelegate {
    @IBOutlet weak var toDoTableview: UITableView!
    let toDodataManager = ToDoListDataManager()
    var toDoListItems = [ToDoListModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableview.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoItem")
        toDoTableview.allowsSelection = false
        toDoListItems = toDodataManager.getItems()
    }
    
    func loadToDoListItems() {
        DispatchQueue.main.async {
            self.toDoTableview.reloadData()
        }
    }

    @IBAction func addNewItem() {
        let alert = UIAlertController(
            title: "Add Item", message: nil,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Write an Item"
        }
        let cancel = UIAlertAction(
            title: "Cancel",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: { [weak self] _ in
                guard let self = self,
                      let itemTextFields = alert.textFields,
                      let itemText = itemTextFields[0] .text else {
                     return
                }
                self.toDoListItems.append(ToDoListModel(item: itemText))
                self.toDodataManager.saveData(self.toDoListItems)
                self.loadToDoListItems()
            }
        )
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ToDoItem",
            for: indexPath
        ) as? ToDoTableViewCell else {
            fatalError("Cell not found")
        }
        cell.textLabel?.text = toDoListItems[indexPath.row].item
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            toDoListItems.remove(at: indexPath.row)
            toDodataManager.saveData(toDoListItems)
            loadToDoListItems()
        }
    }
}

