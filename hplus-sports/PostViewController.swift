//
//  PostViewController.swift
//  hplus-sports
//
//  Created by Saul Mora on 2/12/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit

final class PostViewController: UIViewController
{
  @IBOutlet private var webView: UIWebView!
  @IBOutlet private weak var customNavigationBar: UINavigationBar!
  
  var post: Post?
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    if let post = post
    {
      customNavigationBar.topItem?.title = post.title
      webView.loadHTMLString(post.content, baseURL: nil)
    }
  }
}

extension PostViewController: UINavigationBarDelegate
{
  func position(for bar: UIBarPositioning) -> UIBarPosition
  {
    return .topAttached
  }
}
