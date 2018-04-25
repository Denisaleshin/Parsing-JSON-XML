//
//  Post.swift
//  hplus-sports
//
//  Created by Saul Mora on 2/12/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import Foundation

struct Post
{
  let id: String
  let title: String
  let content: String
  let date: Date
}

func fakePosts() -> [Post]
{
  return [
    Post(id: "1", title: "Store Now Open", content: "Come and see our awesome store!", date: Date())
  ]
}

