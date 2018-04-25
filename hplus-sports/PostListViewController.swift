//
//  OrdersViewController.swift
//  hplus-sports
//
//  Created by Saul Mora on 2/12/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit
import Foundation

final class PostListViewController: UIViewController
{
  @IBOutlet private var postsTableView: UITableView!
  private var refreshControl: UIRefreshControl?
  
  fileprivate var posts: [Post] = []
  {
    didSet
    {
      self.postsTableView.reloadData()
      self.refreshControl?.endRefreshing()
    }
  }
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
    postsTableView.refreshControl = refreshControl
  }
  
  override func viewDidAppear(_ animated: Bool)
  {
    super.viewDidAppear(animated)
    guard let selectedIndexPath = postsTableView.indexPathForSelectedRow else { return }
    postsTableView.deselectRow(at: selectedIndexPath, animated: animated)
  }

  dynamic private func loadPosts()
  {
    self.posts = fakePosts()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    guard
      let postViewController = segue.destination as? PostViewController,
      let selectedIndexPath = postsTableView.indexPathForSelectedRow
    else
      { return }
    
    postViewController.post = posts[selectedIndexPath.row]
  }
  
  @IBAction func exitToPostsView(segue: UIStoryboardSegue)
  {
  }
}

extension PostListViewController: UITableViewDataSource
{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let post = posts[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath)
    cell.textLabel?.text = post.title
    cell.detailTextLabel?.text = post.content
    return cell
  }
}

extension PostListViewController: UINavigationBarDelegate
{
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
}

