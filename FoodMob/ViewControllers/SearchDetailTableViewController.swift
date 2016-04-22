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

private enum DetailCell: Int {
    case PhoneCell = 0
    case AddressCell = 1
    case YelpCell = 2
}

class SearchDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var restaurant: Restaurant! {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    func configureView() {
        if let restaurant = restaurant, _ = nameLabel {
            self.nameLabel.text = restaurant.name
            self.categoriesLabel.text = restaurant.categoriesString
            self.phoneLabel.text = restaurant.phoneNumber
            self.addressLabel.text = restaurant.address
            if let url = restaurant.imageURL {
                heroImageView.af_setImageWithURL(url.yelpHiResURL!)
            }
            heroImageView.image = heroImageView.image?.applyBlurWithRadius(3, tintColor: UIColor(white: 0.10, alpha: 0.75), saturationDeltaFactor: 1)
            ratingView.rating = restaurant.stars
            ratingView.text = "\(restaurant.numReviews) reviews "
            ratingView.settings.updateOnTouch = false
            ratingView.settings.emptyBorderColor = UIColor.whiteColor()
            ratingView.settings.filledBorderColor = UIColor.whiteColor()
            ratingView.settings.textColor = UIColor.whiteColor()
            ratingView.settings.textFont = UIFont.systemFontOfSize(openLabel.font.pointSize)
            ratingView.settings.filledColor = UIColor.whiteColor()
            ratingView.settings.fillMode = .Half
            ratingView.backgroundColor = UIColor.clearColor()
            
            self.title = restaurant.name
            
            let geocoder = CLGeocoder()
            var location: CLLocation?
            let annotation = MKPointAnnotation()
            var currentRegion: CLCircularRegion? = nil
            if let myLocation = Session.sharedSession.locationManager.location {
                currentRegion = CLCircularRegion(center: myLocation.coordinate, radius: 10_000, identifier: "Near Me")
            }
            geocoder.geocodeAddressString(restaurant.address, inRegion: currentRegion) { [unowned self] (placemarks, error) in
                if let placemarks = placemarks, first = placemarks.first {
                    location = first.location
                }
                var coordinate = CLLocationCoordinate2D(latitude: 33.7802445, longitude: -84.3861063)
                if let foundLoc = location {
                    coordinate = foundLoc.coordinate
                }
                let regionRadius: Double = 100
                annotation.coordinate = coordinate
                self.map.addAnnotation(annotation)
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 1.5, regionRadius * 1.5)
                self.map.setRegion(coordinateRegion, animated: true)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.map = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case DetailCell.PhoneCell.rawValue:
                UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(restaurant.phoneNumber)")!)
            case DetailCell.AddressCell.rawValue:
                let location = map.annotations.filter { ($0 as? MKPointAnnotation) != nil }.last!
                let encodedName = restaurant.name.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                let encodedLat = "\(location.coordinate.latitude)".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
                let encodedLong = "\(location.coordinate.longitude)".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
                UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.apple.com/?z=3&q=\(encodedName)&ll=\(encodedLat),\(encodedLong)")!)
            case DetailCell.YelpCell.rawValue:
                if let url = restaurant.yelpURL {
                    UIApplication.sharedApplication().openURL(url)
                }
            default:
                print("Not implemented")
            }
        }
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
