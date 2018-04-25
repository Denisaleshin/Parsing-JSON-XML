//
//  Product.swift
//  hplus-sports
//
//  Created by Saul Mora on 2/12/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import Foundation

struct Product
{
  let id: String
  let name: String
  let description: String?
  let date: Date?
  fileprivate let imageURLString: String
  let imageTitle: String
  let formattedPrice: String?
  
  var imageURL: URL?
  {
    return URL(string: imageURLString)
  }
}

func fakeProducts() -> [Product]
{
  return [
    Product(id: "1", name: "Something1", description: "Not sure what this does", date: Date(), imageURLString: "http://notarealhostname.com/image.png", imageTitle: "Don't load this URL", formattedPrice: "$1.34"),
    Product(id: "2", name: "Bag of Awesome", description: "All the awesomeness you need in a handy bag", date: Date(), imageURLString: "http://imagesrus.com/fakeimage.png", imageTitle: "Don't load this image URL either", formattedPrice: "$234.13"),
    Product(id: "3", name: "Ray of Sunshine", description: "A single ray of sunshine, moonshine sold separately", date: Date(), imageURLString: "http://moarimages.com/sun+moon+happy.png", imageTitle: "Oh yeah!", formattedPrice: "$39.99")
  ]
}

extension Product: JSONDecodable
{
    init(_ decoder: JSONDecoder) throws
    {
        self.id = try decoder.value(forKey: "id")
        self.name = try decoder.value(forKey: "name")
        self.imageTitle = try decoder.value(forKey: "image_title")
        self.imageURLString = try decoder.value(forKey: "image")
        
        self.description = try? decoder.value(forKey: "description")
        self.formattedPrice = try? decoder.value(forKey: "price")
        self.date = try? decoder.value(forKey: "date")
    }
}
