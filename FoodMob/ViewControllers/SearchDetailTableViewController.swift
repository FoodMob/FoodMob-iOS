//
//  SearchDetailTableViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/16/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Cosmos

class SearchDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let geocoder = CLGeocoder()
        var location: CLLocation?
        geocoder.geocodeAddressString("933 Peachtree St, Atlanta, GA 30309") { [unowned self] (placemarks, error) in
            if let placemarks = placemarks, first = placemarks.first {
                location = first.location
            }
            var coordinate = CLLocationCoordinate2D(latitude: 33.7802445, longitude: -84.3861063)
            if let foundLoc = location {
                coordinate = foundLoc.coordinate
            }
            let regionRadius: Double = 100
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2.25, regionRadius * 2.25)
            self.map.setRegion(coordinateRegion, animated: true)
        }
        heroImageView.image = heroImageView.image?.applyBlurWithRadius(10, tintColor: UIColor(white: 0.10, alpha: 0.73), saturationDeltaFactor: 1.8)
        ratingView.rating = 4.5
        ratingView.text = "59 reviews "
        ratingView.settings.updateOnTouch = false
        ratingView.settings.emptyBorderColor = UIColor.whiteColor()
        ratingView.settings.filledBorderColor = UIColor.whiteColor()
        ratingView.settings.textColor = UIColor.whiteColor()
        ratingView.settings.textFont = UIFont.systemFontOfSize(openLabel.font.pointSize)
        ratingView.settings.filledColor = UIColor.whiteColor()
        ratingView.settings.fillMode = .Half
        ratingView.backgroundColor = UIColor.clearColor()
        
        self.title = "Sweet Hut Bakery & Cafe"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.map = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
