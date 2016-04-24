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
    case ToWebSegue = "profileToWebSegue"
}

class ProfileTableViewController: UITableViewController, CategoryDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dislikesLabel: UILabel!
    @IBOutlet weak var restrictionsLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    private var currentUser: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Session.sharedSession.currentUser!
        userImage.setImageForUser(currentUser)
        FoodMob.currentDataProvider.fetchCategoriesForUser(currentUser) {
            [weak self] success in
            if success {
                self?.likesLabel.text = self?.currentUser.stringForPreference(.Like)
                self?.dislikesLabel.text = self?.currentUser.stringForPreference(.Dislike)
                self?.restrictionsLabel.text = self?.currentUser.stringForPreference(.Restriction)
                self?.tableView.reloadData()
            }
        }
        nameLabel.text = currentUser.fullName
        emailLabel.text = currentUser.emailAddress
        
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


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? FoodCategoriesTableViewController, sender = sender as? Int, pref = Preference(rawValue: sender) {
            dest.showingPreference = pref
            dest.delegate = self
            dest.selectedCategories = Set<FoodCategory>(currentUser.categoriesForPreference(pref))
        }
        if let dest = segue.destinationViewController as? FMWebViewController, sender = sender as? NSURL {
            dest.url = sender
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
            let url = NSBundle.mainBundle().URLForResource("legal", withExtension: "html")!
            self.performSegueWithIdentifier(ProfileTableViewControllerSegue.ToWebSegue.rawValue, sender: url)
        case .Help:
            let url = NSBundle.mainBundle().URLForResource("help", withExtension: "html")!
            self.performSegueWithIdentifier(ProfileTableViewControllerSegue.ToWebSegue.rawValue, sender: url)
        default:
            print("Not implemented yet")
        }
    }
    
    @IBAction func unwindToProfilePage(segue: UIStoryboardSegue) {
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    func didFinishSelectingCategories(categories: Set<FoodCategory>, forPreference preference: Preference) {
        let removedCats = Set<FoodCategory>(currentUser.categoriesForPreference(preference)).subtract(categories)
        for category in categories {
            currentUser.setPreference(preference, forCategory: category)
        }
        for category in removedCats {
            currentUser.setPreference(.None, forCategory: category)
        }
        currentDataProvider.updateCategoriesForUser(currentUser)
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

