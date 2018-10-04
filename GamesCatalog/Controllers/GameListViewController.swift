//
//  ViewController.swift
//  GamesCatalog
//
//  Created by Diego Lopes on 02/10/18.
//  Copyright © 2018 Diego Lopes. All rights reserved.
//

import UIKit
import CoreData

class GameListViewController: UITableViewController {

    var itemArray = [Game]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Game.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGames()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameListCell", for: indexPath)
    
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
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
            
            let newGame = Game(context: self.context)
            newGame.title = titleField.text!
            
            self.itemArray.append(newGame)
            
            self.saveGames()
            
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
    
    func saveGames() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadGames(with request: NSFetchRequest<Game> = Game.fetchRequest()){
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }
}

//MARK: - Search bar methods

extension GameListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Game> = Game.fetchRequest()
        
        let predicate1 = NSPredicate(format: "title contains[c] %@", searchBar.text!)
        let predicate2 = NSPredicate(format: "console contains[c] %@", searchBar.text!)
        request.predicate = NSCompoundPredicate.init(type: .or, subpredicates: [predicate1,predicate2])
        
        request.sortDescriptors = [NSSortDescriptor(key: "date_of_completion", ascending: false)]
        
        loadGames(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadGames()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

