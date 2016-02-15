//
//  ProfileTableViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/9/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit
import SafariServices

enum ProfileTableViewControllerSegue: String {
    case ToLoginSegue = "profileToLoginSegue"
    case ToCategoriesSegue = "profileToCategoriesSegue"
}

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dislikesLabel: UILabel!
    @IBOutlet weak var restrictionsLabel: UILabel!
    
    private var currentUser: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Session.sharedSession.currentUser!
        FoodMob.currentDataProvider.fetchCategoriesForUser(currentUser) {
            [unowned self] success in
            if success {
                self.likesLabel.text = self.currentUser.stringForPreference(.Like)
                self.dislikesLabel.text = self.currentUser.stringForPreference(.Dislike)
                self.restrictionsLabel.text = self.currentUser.stringForPreference(.Restriction)
                self.tableView.reloadData()
            }
        }
        nameLabel.text = currentUser.fullName
        emailLabel.text = currentUser.emailAddress
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        likesLabel.text = currentUser.stringForPreference(.Like)
        dislikesLabel.text = currentUser.stringForPreference(.Dislike)
        restrictionsLabel.text = currentUser.stringForPreference(.Restriction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 2
//    }

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
        if let dest = segue.destinationViewController as? FoodCategoriesTableViewController, sender = sender as? Int, pref = Preference(rawValue: sender) {
            dest.showingPreference = pref
        }
    }

    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            selectedAboutMeRow(indexPath.row)
        case 1:
            selectedAccountRow(indexPath.row)
        default:
            print("Not implemented")
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func selectedAboutMeRow(row: Int) {
        guard let row = AboutMeRow(rawValue: row) else { return }
        
        switch row {
        case .Likes:
            self.performSegueWithIdentifier(ProfileTableViewControllerSegue.ToCategoriesSegue.rawValue, sender: Preference.Like.rawValue)
        case .Dislikes:
            self.performSegueWithIdentifier(ProfileTableViewControllerSegue.ToCategoriesSegue.rawValue, sender: Preference.Dislike.rawValue)
        case .Restrictions:
            self.performSegueWithIdentifier(ProfileTableViewControllerSegue.ToCategoriesSegue.rawValue, sender: Preference.Restriction.rawValue)
        default:
            print("Not implemented yet")
        }
    }
    
    func selectedAccountRow(row: Int) {
        guard let row = AccountRow(rawValue: row) else { return }
        
        switch row {
        case .SignOut:
            FoodMob.currentDataProvider.logout(Session.sharedSession.currentUser!, completion: { (success) in
                print("Logout successful? \(success)")
            })
            Session.sharedSession.currentUser = nil
            self.performSegueWithIdentifier(ProfileTableViewControllerSegue.ToLoginSegue.rawValue, sender: nil)
        case .Legal:
            let _ = NSBundle.mainBundle().URLForResource("legal", withExtension: "html")!
        default:
            print("Not implemented yet")
        }
    }
    
    @IBAction func unwindToProfilePage(segue: UIStoryboardSegue) {
    }
}

enum AboutMeRow: Int {
    case Profile = 0
    case Likes = 1
    case Dislikes = 2
    case Restrictions = 3
}

enum AccountRow: Int {
    case PasswordSecurity = 0
    case Help = 1
    case Legal = 2
    case SignOut = 3
}

