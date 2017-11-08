//
//  PostViewController.swift
//  ApolloMission
//
//  Created by Ricardo Gehrke Filho on 08/11/17.
//  Copyright © 2017 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import Apollo

class PostViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var postId: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPost()
    }
    
    func fetchPost() {
        guard let apolloClient = Apollo.shared.client else { return }
        guard let postId = postId else { return }
        let query = PostByIdQuery(id: postId)
        
        // This fetch will not make a sever request.
        // Data was already cached when PostsTableViewController fetched the whole list of posts
        apolloClient.fetch(query: query) { result, error in
            if let post = result?.data?.post?.fragments.postObject {
                self.titleLabel.text = post.title
                self.contentLabel.text = post.content
            }
        }
    }
    
}
