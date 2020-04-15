//
//  ViewController.swift
//  ToDo
//
//  Created by Aung Ko Min on 11/4/20.
//  Copyright © 2020 Aung Ko Min. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var tasks = [Task]()
    
    private var currentCreatingTaskTitle: String?
    private var currentCreatingTaskDetails: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "To Do"
        
        let plusButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButtonItem(_:)))
        navigationItem.rightBarButtonItem = plusButtonItem
        
        // Registering ToDoTableViewCell to tableView
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.reuseIdentifier)
        
        // tableView datasource and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        updateTasks()
    }
}

extension ViewController {
    
    private func updateTasks() {
        guard let context = AppDelegate.shared?.persistentContainer.viewContext else { return }
        let fetchRequest: NSFetchRequest<Task> = NSFetchRequest(entityName: "Task")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "created", ascending: false)] // Sort
        do {
            let tasks = try context.fetch(fetchRequest)
            self.tasks = tasks
        } catch {
            showError(title: "Error", message: error.localizedDescription)
        }
    }
    
    // OK. Create Task in coreData
    // Task or Tesk... I'm not sure :)
    private func createTask(title: String, details: String, date: Date) {
        // Whenever we use coredate, this context is needed
        guard let context = AppDelegate.shared?.persistentContainer.viewContext else { return }
        print(context)
        // so we create task
        let task = Task(context: context)
        task.title = title
        task.detils = details
        task.target = date
        task.created = Date() // Created Just Now
        task.edited = Date() // Edited also Now
        AppDelegate.shared?.saveContext()
        // That's it... Task is created
        self.updateTasks()
        // Reload TableView
        self.tableView.reloadData()
        
    }
}

// Add Date Alert (Just making codes easier to read. nothing special)
extension ViewController {
    @objc private func didTapAddButtonItem(_ sender: UIBarButtonItem) {
        // We will show the alert with textFields here
        // 1. Create alertController
        let alert = UIAlertController(title: "Add Task", message: "Blah Blah.. blah", preferredStyle: .alert)
        // Add Title TextField
        alert.addTextField { x in
            x.placeholder = "Task Title"
        }
        // Detail TextField
        alert.addTextField { x in
            x.placeholder = "Task Details"
        }
        // OK Action
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // get the textFields' values
            guard let titleText = alert.textFields?[0].text,
                let detailText = alert.textFields?[1].text,
                !titleText.isEmpty && !detailText.isEmpty
            else {
                    // we will show error here
                    self.showError(title: "Error", message: "Task title or task details cannot be empty")
                    return
            }
            // Let's temporary store the titleText and detailText at somewhere and wait for datePicker to pick date
            self.currentCreatingTaskTitle = titleText
            self.currentCreatingTaskDetails = detailText
            // Present datePickerViewController
            let datePicker = DatePickerViewController()
            datePicker.delegate = self
            // but... to display titles, and button, it's better to wrap datePicker into NavigationController... like this...
            let dateNav = UINavigationController(rootViewController: datePicker)
            self.present(dateNav, animated: true, completion: nil)
        }
        alert.addAction(okAction)
        // Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        // Present Alert
        self.present(alert, animated: true, completion: nil)
    }
}

// DatePickerViewController Delegate
extension ViewController: DatePickerViewControllerDelegate {
    
    func datePickerViewController(_ controller: DatePickerViewController, didFinishPicking date: Date) {
        // when creating tasks, date cannot be past date right? (Logic!)
        // so if date is past date, we show error
        
        guard date.timeIntervalSinceNow > 0 else {
            print("Error")
            self.showError(title: "Error", message: "Date should be future-date")
            return
        }
        // So we check everything
        guard let title = self.currentCreatingTaskTitle,
            let details = self.currentCreatingTaskDetails else {
                // You can show error here also
                return
        }
        // So we get everything here
        self.createTask(title: title, details: details, date: date)
    }
    
    func datePickerViewController(datePickerDidCancel controller: DatePickerViewController) {
        print("datePickerViewController cancelled")
    }

}

// TableView Delegate/Datasource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // We have to return cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseIdentifier, for: indexPath) as? ToDoTableViewCell else {
            fatalError()
        }
        
        let task = tasks[indexPath.row]
        // This textLabel and detailTextLabel are built in... but we won't use them anymore
        // to make it better, we send task model to cell
        cell.configure(task)
        
        return cell
    }
}
