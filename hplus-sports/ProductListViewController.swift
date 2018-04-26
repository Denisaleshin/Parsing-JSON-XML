//
//  ProductsViewController.swift
//  hplus-sports
//
//  Created by Saul Mora on 2/12/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit
import Foundation

final class ProductListViewController: UIViewController
{
    @IBOutlet private var productsTableView: UITableView!
    
    var products: [Product] = []
    {
        didSet
        {
            self.productsTableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadProducts()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        guard let selectedIndexPath = productsTableView.indexPathForSelectedRow else { return }
        productsTableView.deselectRow(at: selectedIndexPath, animated: animated)
    }
    enum HTTPEror: Error {
        case invalidResponse
        case invalidStatusCode
        case requestFaled(statusCode: Int, message: String)
    }
    
    enum HTTPStatusCode: Int {
        case success = 200
        case notFound = 404
        var isSuccessful: Bool {
            return (200..<300).contains(rawValue)
        }
        var message: String {
            return HTTPURLResponse.localizedString(forStatusCode: rawValue)
        }
        
    }
    
    func validate(_ response: URLResponse?) throws {
        guard let response = response as? HTTPURLResponse else {
            throw HTTPEror.invalidResponse
        }
        guard let status = HTTPStatusCode(rawValue: response.statusCode) else {
            throw HTTPEror.invalidStatusCode
        }
        
        if !status.isSuccessful {
            throw HTTPEror.requestFaled(statusCode: status.rawValue, message: status.message)
        }
    }
    
    let session: URLSession = .shared
    private func loadProducts()
    {
        let url = URL(string: "http://hplussport.com/api/products/format/xml")!
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
            try self.validate(response)
             self.products = try parseXML(data: data, elementName: "product")
                
            } catch {
                print("JSONParsin Error: \(error)")
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard
            let productViewController = segue.destination as? ProductViewController,
            let selectedIndexPath = productsTableView.indexPathForSelectedRow
            else
        { return }
        
        productViewController.product = products[selectedIndexPath.row]
    }
    
    @IBAction func exitToProductsView(segue: UIStoryboardSegue)
    {
    }
}

extension ProductListViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
        
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.description
        return cell
    }
}

extension ProductListViewController: UINavigationBarDelegate
{
    func position(for bar: UIBarPositioning) -> UIBarPosition
    {
        return .topAttached
    }
}

