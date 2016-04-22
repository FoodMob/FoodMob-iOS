//
//  SearchConfigurationTableViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 3/13/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

class SearchConfigurationTableViewController: UITableViewController {

    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var priceSelection: UISegmentedControl!
    @IBOutlet weak var starSearch: UISegmentedControl!
    var search = RestaurantSearch()
    
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

//    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if self.locationField.text != "" {
            search.locationString = self.locationField.text
        } else if let location = Session.sharedSession.locationManager.location  {
            search.location = location.coordinate
        } else {
            alert("Location Not Available", message: "FoodMob could not get your current location.")
        }

        // search.priceRange = PriceRange(rawValue: priceSelection.selectedSegmentIndex) ?? .Any
        search.stars = starSearch.selectedSegmentIndex + 1

        if let destination = segue.destinationViewController as? SearchTableViewController {
            currentDataProvider.fetchRestaurantsForSearch(self.search, withUser: Session.sharedSession.currentUser!, completion: { (restaurants) in
                destination.restaurants = restaurants
            })
        }
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Custom Navigation Bar
        let bar:UINavigationBar! = self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor(hue: 0.5, saturation: 0.851, brightness: 0.959, alpha: 0.0)
        return true
    }
    /**
     Called when the user scrolled the tableView. Updates the headerView and checks to change the navigation bar's backgroundColor to solid or not.
     
     - parameter scrollView: ScrollView
     */
    /*override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -CGRectGetHeight(customNavigationBarView.frame) {
            customNavigationBarView.adjustBackground(false)
        } else {
            customNavigationBarView.adjustBackground(true)
        }
    }*/

}
