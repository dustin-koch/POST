//
//  PostController.swift
//  Post
//
//  Created by Dustin Koch on 5/13/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation

class PostController {
    
    static let shared = PostController()
    let baseURL = URL(string: "http://devmtn-posts.firebaseio.com/posts")
    var posts: [Post] = []
    
    func addPostWith(userName: String, text: String, completion: @escaping () -> Void){
        let post = Post(text: text, username: userName)
        var postData: Data?
        do {
            let jsonEncoder = JSONEncoder()
            postData = try jsonEncoder.encode(post)
        } catch  {
            print(error.localizedDescription)
        }

        guard let url = baseURL else { return }
        let postEndpoint = url.appendingPathExtension("json")
        var request = URLRequest(url: postEndpoint)
        request.httpMethod = "POST"
        request.httpBody = postData

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            self.fetchPosts() {
                completion()
            }
        }.resume()
    }//END OF ADD POST
    
    func fetchPosts(completion: @escaping () -> Void ) {
        guard let url = baseURL else { return }
        let getterEndpoint = url.appendingPathExtension("json")
        
        let dataTask = URLSession.shared.dataTask(with: getterEndpoint) {
            (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            do {
                let postsDictionary = try jsonDecoder.decode([String:Post].self, from: data)
                var posts = postsDictionary.compactMap({$0.value})
                posts.sort(by: { $0.timestamp > $1.timestamp })
                self.posts = posts
                completion()
            } catch  {
                print(error.localizedDescription)
                completion()
                return
            }
        }
        dataTask.resume()
    }//END OF FETCH POST
}//END OF CLASS
