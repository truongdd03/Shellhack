//
//  LobbyViewController.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import UIKit

class LobbyViewController: UIViewController {

    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.setToolbarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(LogInButton)
        Utilities.styleHollowButton(SignUpButton)
        
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "isLoggedIn") == true {
            let storyBoard = UIStoryboard(name: "TabBar", bundle: nil)
            let vc = storyBoard.instantiateViewController(identifier: "Main") as! UITabBarController
            navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}


