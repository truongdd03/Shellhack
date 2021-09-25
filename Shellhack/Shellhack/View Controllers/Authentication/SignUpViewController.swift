//
//  SignUpViewController.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var FirstNameInput: UITextField!
    @IBOutlet weak var LastNameInput: UITextField!
    @IBOutlet weak var EmailInput: UITextField!
    @IBOutlet weak var PasswordInput: UITextField!
    @IBOutlet weak var PasswordInput1: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = "Sign Up"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleTextField(FirstNameInput)
        Utilities.styleTextField(LastNameInput)
        Utilities.styleTextField(EmailInput)
        Utilities.styleTextField(PasswordInput)
        Utilities.styleTextField(PasswordInput1)
        Utilities.styleFilledButton(SignUpButton)
    }
    
    func validateInputs() -> Bool {
        if FirstNameInput.text == nil || LastNameInput.text == nil || EmailInput.text == nil || PasswordInput.text == nil || PasswordInput1.text == nil {
            showError(message: "Please fill all fields")
            return false
        }
        
        if PasswordInput.text != PasswordInput1.text {
            showError(message: "Password and confirm password don't match")
            return false
        }
        
        if FirstNameInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || LastNameInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showError(message: "Invalid first/last name")
        }
        
        return true
    }
    
    func showError(message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func transitToNewsfeed() {
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "isLoggedIn")
    
        let storyBoard = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "Main") as! UITabBarController
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        if !validateInputs() { return }
        
        let email = EmailInput.text!
        let username = FirstNameInput.text! + " " + LastNameInput.text!
        let password = PasswordInput.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if let err = err {
                self.showError(message: err.localizedDescription)
                return
            }

            Writer.writeUsername(username: username)
            self.transitToNewsfeed()
        }
    }
}

