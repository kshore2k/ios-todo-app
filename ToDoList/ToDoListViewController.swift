//
//  ViewController.swift
//  ToDoList
//
//  Created by Kris Shore on 4/23/19.
//  Copyright © 2019 Kris Shore. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
//    Initialized Array of Data Model Entity
    var toDoList = [ToDoListItem]()
    
//    PersistentContainer reference for CRUD
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    AppDelegate save function reference for CRUD
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        fetchAllItems()
    }
    
//    Perform Segue via Add Button
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddItemSegue", sender: sender)
    }
    
//    TableView Protocol
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        cell.textLabel?.text = toDoList[indexPath.row].title
        cell.detailTextLabel?.text = toDoList[indexPath.row].details
        
        return cell
    }
    
//    Prepare for segue / Set AddItemViewController delegate as ToDoListViewController(self)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let addItemViewController = navigationController.topViewController as! AddItemViewController
        addItemViewController.delegate = self
    }
    
//    Fetch all items from CoreData
    func fetchAllItems(){
        let request: NSFetchRequest<ToDoListItem> = ToDoListItem.fetchRequest()
        do {
            let result = try context.fetch(request)
            toDoList = result
        } catch {
            print("error")
        }
    }
    
//    Click to add Check Mark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
//    Swipe to delete item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = toDoList[indexPath.row]
        context.delete(item)
        
        saveContext()
        
        toDoList.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
}

extension ToDoListViewController: AddItemDelegate {
    func addItemButtonPressed(for controller: AddItemViewController, with title: String, and details: String, for date: Date) {
        print("made it to delegate")
        let item = ToDoListItem(context: context)
        item.title = title
        item.details = details
        item.date = date
        toDoList.append(item)
        
        saveContext()
        
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
    
}

