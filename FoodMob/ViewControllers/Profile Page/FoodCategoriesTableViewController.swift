//
//  FoodCategoriesTableViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/10/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

protocol CategoryDelegate: class {
    func didFinishSelectingCategories(categories: Set<FoodCategory>, forPreference preference: Preference)
}

class FoodCategoriesTableViewController: UITableViewController {

    internal var showingPreference = Preference.None
    private var categories: [FoodCategory]!
    var selectedCategories = Set<FoodCategory>()
    weak var delegate: CategoryDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = showingPreference.showingTypeString
        currentDataProvider.fetchCategoryListing { [unowned self] (categories: Dictionary<String, FoodCategory>) in
            self.categories = Array(categories.values).sort({ (cat0, cat1) -> Bool in
                return cat0.displayName < cat1.displayName
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.didFinishSelectingCategories(selectedCategories, forPreference: showingPreference)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoriesCellReuseIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = categories[indexPath.row].displayName
        if selectedCategories.contains(categories[indexPath.row]) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) else { return }
        let wasSwitchedOn = cell.accessoryType != .Checkmark
        cell.accessoryType = (wasSwitchedOn) ? .Checkmark : .None
        if wasSwitchedOn {
            selectedCategories.insert(categories[indexPath.row])
        } else {
            selectedCategories.remove(categories[indexPath.row])
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
