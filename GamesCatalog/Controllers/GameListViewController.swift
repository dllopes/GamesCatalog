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

    var gamesArray = [Game]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Game.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadGames()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameListCell", for: indexPath)
    
        let game = gamesArray[indexPath.row]
        
        cell.textLabel?.text = game.title
        
        cell.accessoryType = game.completed ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        gamesArray[indexPath.row].completed = !gamesArray[indexPath.row].completed
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadGames(with request: NSFetchRequest<Game> = Game.fetchRequest()){
        
        do {
            gamesArray = try context.fetch(request)
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

