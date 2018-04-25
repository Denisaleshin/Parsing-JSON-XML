//
//  ProductDetailViewController.swift
//  hplus-sports
//
//  Created by Saul Mora on 2/12/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit
import Foundation

final class ProductViewController: UIViewController
{
  @IBOutlet private var productImage: UIImageView!
  @IBOutlet private var productTitle: UILabel!
  @IBOutlet private var productDescription: UILabel!
  @IBOutlet private var customNavigationBar: UINavigationBar!
  
  var product: Product?
  
  override func viewWillAppear(_ animated: Bool)
  {
    super.viewWillAppear(animated)
    
    if let product = product
    {
      title = product.name
      productTitle.text = product.name
      productDescription.text = product.description
    }
    customNavigationBar.topItem?.title = title
  }
  
  @IBAction func buyProduct()
  {
    let message = "\(product?.name ?? "Unknown") has been placed in your shopping cart"
    let alert = UIAlertController(title: "Shopping Cart", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

extension ProductViewController: UINavigationBarDelegate
{
  func position(for bar: UIBarPositioning) -> UIBarPosition
  {
    return .topAttached
  }
}

