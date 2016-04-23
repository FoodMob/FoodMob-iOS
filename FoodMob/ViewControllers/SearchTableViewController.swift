//
//  SearchTableViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/16/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

enum SearchTableViewControllerSegue: String {
    case ToDetail = "searchToDetailSegue"
}

class SearchTableViewController: UITableViewController {
    
    var lastSelectedIndexPath: NSIndexPath?
    
    var restaurants = [Restaurant]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as! SearchResultsTableViewCell
        let restaurant = restaurants[indexPath.row]
        cell.name?.text = restaurant.name
        cell.categories?.text = restaurant.categoriesString
        if let imageURL = restaurant.imageURL {
            cell.img?.af_setImageWithURL(imageURL.yelpHiResURL!,
                                         placeholderImage: UIImage(named: "Default Restaurant Image"),
                                         imageTransition: .CrossDissolve(0.2))
        }
        return cell
    }


    // MARK: - Navigation
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        self.lastSelectedIndexPath = indexPath
        return indexPath
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destinationViewController as? SearchDetailTableViewController, indexPath = lastSelectedIndexPath {
            destination.restaurant = restaurants[indexPath.row]
            lastSelectedIndexPath = nil
        }
    }

}
