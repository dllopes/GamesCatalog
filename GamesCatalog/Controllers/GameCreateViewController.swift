//
//  GameCreateViewController.swift
//  GamesCatalog
//
//  Created by Diego Lopes on 03/10/18.
//  Copyright © 2018 Diego Lopes. All rights reserved.
//

import UIKit
import CoreData

class GameCreateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var gamesArray = [Game]()
    var consolePickerText = ""
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var consoleTextField: UIPickerView!
    @IBOutlet weak var completedBoolField: UISwitch!
    @IBOutlet weak var dateOfCompletionDateField: UIDatePicker!
    
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setMinAndMaxDate()
        
        // Connect data:
        self.consoleTextField.delegate = self
        self.consoleTextField.dataSource = self
        
        pickerData = [" - ", "Playstation 1", "Playstation 2", "Playstation 3", "Xbox ONE", "Xbox 1", "Xbox Classic", "Console 6", "Console 7"]
    }
    

    @IBAction func addGame(_ sender: Any) {
        
        let newGame = Game(context: self.context)
        newGame.title = titleTextField.text!
        newGame.year = Int16(yearTextField.text!)!
        newGame.console = consolePickerText
        newGame.completed = completedBoolField.isOn
        newGame.date_of_completion = dateOfCompletionDateField.date

        self.gamesArray.append(newGame)

        self.saveGames()
    }
    
    func saveGames() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        consolePickerText = pickerData[row] as String
    }
    
    func setMinAndMaxDate(){
        dateOfCompletionDateField.minimumDate = Calendar.current.date(byAdding: .year, value: -50, to: Date())
        dateOfCompletionDateField.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
