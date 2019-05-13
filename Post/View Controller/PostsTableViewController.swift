//
//  PostsTableViewController.swift
//  Post
//
//  Created by Dustin Koch on 5/13/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        PostController.shared.fetchPosts {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Posts"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostController.shared.posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = PostController.shared.posts[indexPath.row]
        let convertedDate = Date(timeIntervalSince1970: post.timestamp)
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "\(post.username) - \(convertedDate.stringValue())"

        return cell
    }

}//END OF CLASS


//Date().timeIntervalSince1970
