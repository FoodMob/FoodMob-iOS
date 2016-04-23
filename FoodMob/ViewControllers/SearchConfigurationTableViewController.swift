//
//  SearchConfigurationTableViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 3/13/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

class SearchConfigurationTableViewController: UITableViewController, FriendTableViewControllerDelegate {

    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var starSearch: UISegmentedControl!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var friendsCell: UITableViewCell!
    var search = RestaurantSearch()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.contentInset.top = -20
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(SearchConfigurationTableViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(SearchConfigurationTableViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    func keyboardDidShow(notification: NSNotification) {
        if let userInfo = notification.userInfo, keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.tableView.contentInset.bottom = keyboardSize.height + 5
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        self.tableView.contentInset.bottom = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func sliderValueUpdated(sender: UISlider) {
        let formattedString = String(format: "%.0f miles", arguments: [distanceSlider.value])
        distanceLabel.text = formattedString
        search.radius = Double(distanceSlider.value) * RestaurantSearch.METERS_PER_MILE
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else { return }

        if identifier == "searchToResultsSegue" {
            if self.locationField.text != "" {
                search.locationString = self.locationField.text
            } else if let location = Session.sharedSession.locationManager.location  {
                search.location = location.coordinate
            } else {
                alert("Location Not Available", message: "FoodMob could not get your current location.")
                return
            }

            search.stars = starSearch.selectedSegmentIndex + 1

            if let destination = segue.destinationViewController as? SearchTableViewController {
                currentDataProvider.fetchRestaurantsForSearch(self.search, withUser: Session.sharedSession.currentUser!, completion: { (restaurants) in
                    destination.restaurants = restaurants
                })
            }
        } else if identifier == "searchToFriendsSegue" {
            let friendsController = segue.destinationViewController as! FriendTableViewController
            friendsController.delegate = self
            friendsController.selectedFriends = self.search.users
        }
    }

    func didFinishSelectingFriends(friends: Set<User>) {
        self.friendsCell.selected = false
        self.search.users = friends
        if friends.count == 0 {
            self.friendsCell.detailTextLabel?.text = "Just Me"
        } else {
            self.friendsCell.detailTextLabel?.text = friends.map { $0.firstName }.joinWithSeparator(", ")
        }
        
    }
}
