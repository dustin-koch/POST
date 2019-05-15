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
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh(sender:AnyObject) {
        PostController.shared.fetchPosts {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        presentNewPostAlert()
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
    
    //MARK: - ALERT CONTROLLER
    func presentNewPostAlert() {
        let alertController = UIAlertController(title: "ADD POST", message: nil, preferredStyle: .alert)
        alertController.addTextField { (usernameTextField) in
            usernameTextField.placeholder = "Enter name..."
        }
        alertController.addTextField { (messageTextField) in
            messageTextField.placeholder = "Enter message..."
        }
        let dismissAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction.init(title: "Add Post", style: .default) { (_) in
            guard let user = alertController.textFields?.first?.text,
            alertController.textFields?.first?.text != "",
            let text = alertController.textFields?.last?.text,
                alertController.textFields?.last?.text != "" else { return }
            PostController.shared.addPostWith(userName: user, text: text, completion: {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        alertController.addAction(addAction)
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
}//END OF CLASS

