//
//  PhotoVC.swift
//  Tmblr
//
//  Created by Joshua Madrigal on 1/30/20.
//  Copyright © 2020 Joshua Madrigal. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoVC: UIViewController {

    var posts: [[String: Any]] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data,
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {

              // TODO: Get the posts and store in posts property
            let responseData = dataDictionary["response"] as! [String: Any]
            self.posts = responseData["posts"] as! [[String: Any]]
            
            // TODO: Reload the table view
            self.tableView.reloadData()
            
          }
        }
        task.resume()
        
    } // end viewDidLoad()

} // end PhotoVC

extension PhotoVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return posts.count
        
     } // end numberOfRowsInSection
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
         let post = posts[indexPath.row]
         
         if let photos = post["photos"] as? [[String: Any]] {
             let photo = photos[0]
             let originalSize = photo["original_size"] as! [String: Any]
             let urlString = originalSize["url"] as! String
             
             let url = URL(string: urlString)
             
             cell.tmblrImage.af_setImage(withURL: url!)
             
             return cell
         }
         
         return cell ?? UITableViewCell()
     } // end cellForRowAt
    
} // end extension

