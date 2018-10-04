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
        print("Teste")
    }
    
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var consoleTextField: UIPickerView!
    @IBOutlet weak var completedBoolField: UISwitch!
    @IBOutlet weak var dateOfCompletionDateField: UIDatePicker!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data:
        self.consoleTextField.delegate = self
        self.consoleTextField.dataSource = self
        
        pickerData = ["Playstation 1", "Playstation 2", "Playstation 3", "Xbox ONE", "Xbox 1", "Xbox Classic", "Console 6", "Console 7"]
//        let alert = UIAlertController(title: "Add new Game", message: "", preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//
//            let newGame = Game(context: self.context)
//            newGame.title = titleField.text!
//
//            self.itemArray.append(newGame)
//
//            self.saveGames()
//
//        }
//
//        //        ActionSheetStringPicker.show(withTitle: "Select a Console", rows:
//        //            ["Console 1", "Console 2", "Console 3", "Console 4", "Console 5"], initialSelection: 0, doneBlock: {
//        //                picker, indexes, values in
//        //
//        //                print("values = \(values)")
//        //                print("indexes = \(indexes)")
//        //                print("picker = \(picker)")
//        //                return
//        //        }, cancel: { ActionSheetStringPicker in return }, origin: sender)
//
//        alert.addAction(action)
//
//        present(alert, animated: true, completion: nil)
    }
    

    @IBAction func addGame(_ sender: Any) {
        
       print(titleTextField.text!)
        print(yearTextField.text!)
        print(pickerData)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var titleTextField: UITextField!
}
