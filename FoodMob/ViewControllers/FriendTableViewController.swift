//
//  FriendTableViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 4/16/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

protocol FriendTableViewControllerDelegate: class {
    func didFinishSelectingFriends(friends: Set<User>)
}

class FriendTableViewController: UITableViewController {

    var selectedFriends = Set<User>()
    weak var delegate: FriendTableViewControllerDelegate? {
        didSet {
            if delegate != nil {
                self.tableView.allowsSelection = true
            } else {
                self.tableView.allowsSelection = false
            }
        }
    }
    private var friends = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(FriendTableViewController.addFriend))
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(FriendTableViewController.reloadDataFromServer), forControlEvents: .ValueChanged)
        self.reloadDataFromServer()
    }

    func addFriend() {
        let popup = UIAlertController(title: "Add Friend", message: nil, preferredStyle: .Alert)
        popup.addTextFieldWithConfigurationHandler { (emailField) in
            emailField.keyboardType = UIKeyboardType.EmailAddress
            emailField.autocorrectionType = .No
            emailField.autocapitalizationType = .None
            emailField.placeholder = "Email address"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (_) in }
        let addAction = UIAlertAction(title: "Add", style: .Default) { [unowned self] (_) in
            if let emailAddress = popup.textFields?.first?.text {
                currentDataProvider.addFriendWithEmail(emailAddress, forUser: Session.sharedSession.currentUser!, completion: { [unowned self] (success, reason) in
                    if success {
                        self.reloadDataFromServer()
                    } else {
                        self.alert("Could not add friend", message: reason)
                    }
                })
            }
        }
        popup.addAction(cancelAction)
        popup.addAction(addAction)
        self.presentViewController(popup, animated: true) {}
    }

    func reloadDataFromServer() {
        currentDataProvider.fetchFriendsListing(forUser: Session.sharedSession.currentUser!) { [unowned self] (users) in
            self.friends = users
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func viewWillDisappear(animated: Bool) {
        delegate?.didFinishSelectingFriends(selectedFriends)
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath)

        guard let friendCell = cell as? FriendTableViewCell else { return cell }
        friendCell.configureCellForUser(friends[indexPath.row])
        if selectedFriends.contains(friends[indexPath.row]) {
            friendCell.accessoryType = .Checkmark
        }
        return friendCell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if delegate != nil {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                if cell.accessoryType == .Checkmark {
                    cell.accessoryType = .None
                    selectedFriends.remove(friends[indexPath.row])
                } else {
                    cell.accessoryType = .Checkmark
                    selectedFriends.insert(friends[indexPath.row])
                }
            }
        }
    }

}
