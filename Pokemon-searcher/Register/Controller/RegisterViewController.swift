//
//  RegisterViewController.swift
//  Pokemon-searcher
//
//  Created by Jonathan Alajoan Rocha on 10/05/21.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var button: UIButton!
    
    // MARK: - IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(textFieldName.text!, forKey: "name")
        
        performSegue(withIdentifier: "favoriteTypeSegue", sender: self)
        textFieldName.endEditing(true)
        print(textFieldName.text!)
    }
    
    // MARK: - Textfield related
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text != "") {
            return true
        } else {
            textField.placeholder = "Enter something to search"
            return false
        }
    }
    
    // MARK: - Views related
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldName.delegate = self
    }

}
