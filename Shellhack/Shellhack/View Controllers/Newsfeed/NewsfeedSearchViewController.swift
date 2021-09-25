//
//  NewsfeedSearchViewController.swift
//  Shellhack
//
//  Created by Don Truong on 9/25/21.
//

import UIKit

class NewsfeedSearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var KeywordsSearchBar: UISearchBar!
    
    static var tags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Name"
        KeywordsSearchBar.delegate = self
        
    }

    func splitKeywords() -> [String] {
        let text = KeywordsSearchBar.text
        var keywords = Index.splitContent(content: text!)
        
        var id = 1
        while id < keywords.count {
            if keywords[id] == keywords[id-1] {
                keywords.remove(at: id)
            } else {
                id += 1
            }
        }
        
        keywords += NewsfeedSearchViewController.tags
        return keywords
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keywords = splitKeywords()
        if keywords.isEmpty { return }
        
        let storyBoard = UIStoryboard(name: "Newsfeed", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "Newsfeed") as! NewsfeedViewController

        Fetcher.filterPostID(keywords: keywords) { (postsID) in
            vc.postsID = postsID
            vc.query = "\(postsID.count) Result(s) for: \(self.KeywordsSearchBar.text!)"
            print(postsID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
