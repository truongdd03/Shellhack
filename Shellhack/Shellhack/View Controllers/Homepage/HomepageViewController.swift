//
//  HomepageViewController.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class HomepageViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    static var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Account"
        nameLabel.text = HomepageViewController.username ?? ""

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.right.doc.on.clipboard"), style: .plain, target: self, action: #selector(logOut))
        
    }
    
    @objc func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            return
        }
        
        let defaults = UserDefaults.standard
        defaults.setValue(false, forKey: "isLoggedIn")
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "Lobby")
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}
