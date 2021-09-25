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
    
    @IBOutlet weak var NotificationLabel: UILabel!
    
    static var username: String?
    static var totalVotes: Int?
    static var rightVotes: Int?
    static var wrongVotes: Int?
    static var votesScores: Int?
    
    var circularProgressBarView: CircularProgressBarView!
    var circularViewDuration: TimeInterval = 1
    
    override func viewWillAppear(_ animated: Bool) {
        updatePointLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Account"
        nameLabel.text = HomepageViewController.username ?? ""

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.right.doc.on.clipboard"), style: .plain, target: self, action: #selector(logOut))

    }
    
    func updatePointLabel() {
        let point = HomepageViewController.calculateOverallPoint()
        PointLabel.text = String(point)
        
        var tmp: CGFloat = CGFloat(point)
        tmp = tmp / 100
        setUpCircularProgressBarView(to: tmp)
        
        if point < 20 {
            NotificationLabel.text = "You are banned due to the low score! You can only read other posts now."
            NotificationLabel.isHidden = false
        } else if point < 50 {
            NotificationLabel.text = "You cannot create new posts! Please vote for others' posts carefully to increase your score."
            NotificationLabel.isHidden = false
        } else {
            NotificationLabel.isHidden = true
        }
        
    }
    
    static func calculateOverallPoint() -> Int{
        var point = 0
        for post in AllPostsViewController.myPosts! {
            point += post.calculatePoint() ?? 0
        }
        
        if AllPostsViewController.myPosts!.count != 0 {
            point = point / AllPostsViewController.myPosts!.count
        }
        
        point = min(100, point + HomepageViewController.votesScores!)
        return point
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
