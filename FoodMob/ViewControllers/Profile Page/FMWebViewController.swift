//
//  FMWebViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 3/7/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

class FMWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var url: NSURL! {
        didSet {
            webView?.loadRequest(NSURLRequest(URL: url))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        webView?.loadRequest(NSURLRequest(URL: url))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
