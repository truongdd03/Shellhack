//
//  NewpostViewController.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import UIKit
import PorterStemmer2

class NewpostViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var AffirmationInput: UITextView!
    @IBOutlet weak var ContentInput: UITextView!
    @IBOutlet weak var PostButton: UIButton!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Posts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "archivebox"), style: .plain, target: self, action: #selector(showPosts))
                        
        setUp()
    }
    
    @objc func showPosts() {
        let storyBoard = UIStoryboard(name: "Newpost", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "Posts")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUp() {
        Utilities.styleTextView(textView: ContentInput)
        Utilities.styleFilledButton(PostButton)
        Utilities.styleTextView(textView: AffirmationInput)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func alert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func validateInputs() -> Bool {
        if (!ContentInput.hasText || !AffirmationInput.hasText) {
            alert(title: "Error", message: "Please fill all fields!")
            return false
        }
        
        return true
    }
    
    func resetInputs() {
        ContentInput.text = ""
        AffirmationInput.text = ""
    }
    
    @IBAction func PostButtonTapped(_ sender: Any) {
        if !validateInputs() { return }
    
        let post = Post(userName: HomepageViewController.username!, date: "", affirmation: AffirmationInput.text, content: ContentInput.text)
        post.updateDate()
        post.id = Writer.writePost(post: post)
        AllPostsViewController.myPosts!.append(MyPost(post: post, point: 0))

        //Index.updatePost(tags: post.tags, content: post.content, postID: post.id!, isDelete: false)
        
        resetInputs()
        alert(title: "Successfully posted!", message: "")
    }
    
}
