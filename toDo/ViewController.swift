//
//  ViewController.swift
//  toDo
//
//  Created by Stephanie Fong on 11/3/18.
//  Copyright © 2018 Stephanie Fong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = toDoItems[indexPath.item].title
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            self.toDoItems.remove(at: indexPath.row)
            self.toDoList.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create the alert controller
        let alertController = UIAlertController(title: toDoItems[indexPath.item].title, message: "", preferredStyle: .alert)
        
        let editController = UIAlertController(title: "Edit Task", message: "", preferredStyle: .alert)
        
        editController.addTextField{
            textField in
            
            textField.text = self.toDoItems[indexPath.item].title
        }
        
        let editTaskAction = UIAlertAction(title: "Edit Task", style: .default) {
            UIAlertAction in
            
            let edittedTask = editController.textFields?.first
            
            self.toDoItems[indexPath.item].title = edittedTask!.text!
            
            self.toDoList.reloadData()
        }
        
        editController.addAction(editTaskAction)
        
        // Create the actions
        let doneAction = UIAlertAction(title: "Done", style: .default)
        
        let editAction = UIAlertAction(title: "Edit", style: .cancel) {
            UIAlertAction in
            
            self.present(editController, animated: true, completion: nil)
        }
        
        // Add the actions
        alertController.addAction(doneAction)
        alertController.addAction(editAction)
        
        //Append the button to the view
        self.present(alertController, animated: true, completion: nil)
    }
    
    var toDoItems: [Task] = []
    
    @IBOutlet weak var newTask: UITextField!

    @IBOutlet weak var toDoList: UITableView!
    
    @IBAction func actionTriggered(_ sender: Any) {
        self.resignFirstResponder()
        self.toDoItems.append(Task(title: self.newTask.text!))
        self.toDoList.reloadData()
        self.newTask.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newTask.delegate = self
        self.toDoList.delegate = self
        self.toDoList.dataSource = self
        self.toDoList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

}

