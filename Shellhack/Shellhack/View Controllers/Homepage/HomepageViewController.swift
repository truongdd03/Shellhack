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
    @IBOutlet weak var PointLabel: UILabel!
    
    static var username: String?
    static var totalVotes: Int?
    static var rightVotes: Int?
    static var wrongVotes: Int?
    static var votesScores: Int?
    
    var circularProgressBarView: CircularProgressBarView!
    var circularViewDuration: TimeInterval = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Account"
        nameLabel.text = HomepageViewController.username ?? ""

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.right.doc.on.clipboard"), style: .plain, target: self, action: #selector(logOut))

        calculateOverallPoint()
    }
    
    func calculateOverallPoint() {
        var point = 0
        for post in AllPostsViewController.myPosts! {
            point += post.calculatePoint() ?? 0
        }
        
        point = min(100, point + HomepageViewController.votesScores!)
        point = point / AllPostsViewController.myPosts!.count
        
        PointLabel.text = String(point)
        
        var tmp: CGFloat = CGFloat(point)
        tmp = tmp / 100
        setUpCircularProgressBarView(to: tmp)
    }
    
    func setUpCircularProgressBarView(to toValue: CGFloat) {
        circularProgressBarView = CircularProgressBarView(frame: .zero)
        circularProgressBarView.center = view.center
        circularProgressBarView.progressAnimation(duration: circularViewDuration, to: toValue)

        view.addSubview(circularProgressBarView)
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
