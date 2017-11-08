//
//  ViewController.swift
//  ApolloMission
//
//  Created by Ricardo Gehrke Filho on 07/11/17.
//  Copyright © 2017 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import Apollo

class PostsTableViewController: UITableViewController {

    var posts: [PostObject] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }
    
    func fetchPosts() {
        if let apolloClient = Apollo.shared.client {
            let query = AllPostsQuery()
            apolloClient.fetch(query: query) { result, error in
                let posts: [PostObject]? = result?.data?.allPosts.map {
                    return $0.fragments.postObject
                }
                self.posts = posts ?? []
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let postViewController = segue.destination as? PostViewController else { return }
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        postViewController.postId = posts[index].id
    }

}

