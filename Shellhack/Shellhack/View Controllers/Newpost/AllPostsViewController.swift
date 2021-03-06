//
//  AllPostsViewController.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import UIKit

class AllPostsViewController: UIViewController {
    static var myPosts: [Post]? = [Post]()
    
    @IBOutlet weak var PostsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Your posts"
                
        PostsTableView.delegate = self
        PostsTableView.dataSource = self
        PostsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        PostsTableView.allowsSelection = false
    }
}

extension AllPostsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllPostsViewController.myPosts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = AllPostsViewController.myPosts![indexPath.row]
                
        cell.affirmation = post.affirmation
        cell.content = post.content
        cell.point = post.calculatePoint()
        print(post.upVotes)
        print(post.calculatePoint())
        cell.date = post.date
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let str = AllPostsViewController.myPosts![indexPath.row].content
        let width = view.frame.size.width - 20
        let height = str.height(withConstrainedWidth: width, font: .systemFont(ofSize: 14))
        return min(height + 120, 400)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = AllPostsViewController.myPosts![indexPath.row]
            
            AllPostsViewController.myPosts!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            Remover.removePost(id: post.id!)
            Index.updatePost(content: post.content, postID: post.id!, isDelete: true)
        }
    }
        
}
