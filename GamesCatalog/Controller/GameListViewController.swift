//
//  ViewController.swift
//  GamesCatalog
//
//  Created by Diego Lopes on 02/10/18.
//  Copyright © 2018 Diego Lopes. All rights reserved.
//

import UIKit

class GameListViewController: UITableViewController {

    var itemArray = ["Game 1", "Game 2", "Game 3", "Game 4", "Game 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameListCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var titleField = UITextField()
        var yearField = UITextField()
        var consoleField = UITextField()
        var completedField = UITextField()
        var dateOfCompletionField = UITextField()
        
        let alert = UIAlertController(title: "Add new Game", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(titleField.text!)
            self.tableView.reloadData()
            print(titleField.text)
            print(yearField.text)
            print(consoleField.text)
            print(completedField.text)
            print(dateOfCompletionField.text)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Title"
            titleField = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Year"
            yearField = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Console"
            consoleField = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Completed"
            completedField = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Date of Completion"
            dateOfCompletionField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

