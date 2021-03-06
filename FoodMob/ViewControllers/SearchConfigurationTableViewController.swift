//
//  SearchConfigurationTableViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 3/13/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

enum SearchConfigurationSegue: String {
    case ToResults = "searchToResultsSegue"
    case ToFriends = "searchToFriendsSegue"
    case ToLikes = "searchToLikesSegue"
    case ToDislikes = "searchToDislikesSegue"
}

class SearchConfigurationTableViewController: UITableViewController, FriendTableViewControllerDelegate, CategoryDelegate, UITextFieldDelegate {

    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var starSearch: UISegmentedControl!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var friendsCell: UITableViewCell!
    @IBOutlet weak var likesCell: UITableViewCell!
    @IBOutlet weak var dislikesCell: UITableViewCell!
    var search = RestaurantSearch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationField.delegate = self
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

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        textField.textAlignment = .Right
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.textAlignment = .Left
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

        if identifier == SearchConfigurationSegue.ToResults.rawValue {
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
        } else if identifier == SearchConfigurationSegue.ToFriends.rawValue {
            let friendsController = segue.destinationViewController as! FriendTableViewController
            friendsController.delegate = self
            friendsController.selectedFriends = self.search.users
        } else if identifier == SearchConfigurationSegue.ToLikes.rawValue {
            let categoriesController = segue.destinationViewController as! FoodCategoriesTableViewController
            categoriesController.delegate = self
            categoriesController.showingPreference = .Like
            categoriesController.selectedCategories = Set<FoodCategory>(self.search.categories.filter { $0.1 == .Like }.map { $0.0 })
        } else if identifier == SearchConfigurationSegue.ToDislikes.rawValue {
            let categoriesController = segue.destinationViewController as! FoodCategoriesTableViewController
            categoriesController.delegate = self
            categoriesController.showingPreference = .Dislike
            categoriesController.selectedCategories = Set<FoodCategory>(self.search.categories.filter { $0.1 == .Dislike }.map { $0.0 })
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

    func didFinishSelectingCategories(categories: Set<FoodCategory>, forPreference preference: Preference) {
        let removedCats = Set<FoodCategory>(search.categories.filter { $0.1 == preference }.map { $0.0 }).subtract(categories)
        for category in categories {
            search.categories[category] = preference
        }

        for category in removedCats {
            search.categories.removeValueForKey(category)
        }
        let likes = search.categories.filter{ $0.1 == .Like }
        if likes.count == 0 {
            likesCell.detailTextLabel?.text = "None"
        } else {
            likesCell.detailTextLabel?.text = likes.map { $0.0.displayName }.joinWithSeparator(", ")
        }
        let dislikes = search.categories.filter{ $0.1 == .Dislike }
        if dislikes.count == 0 {
            dislikesCell.detailTextLabel?.text = "None"
        } else {
            dislikesCell.detailTextLabel?.text = dislikes.map { $0.0.displayName }.joinWithSeparator(", ")
        }
        likesCell.selected = false
        dislikesCell.selected = false
    }
}
