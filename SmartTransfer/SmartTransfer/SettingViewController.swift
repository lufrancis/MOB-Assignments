//
//  SettingViewController.swift
//  SmartTransfer
//
//  Created by Francis Lu on 15/8/15.
//  Copyright (c) 2015 Francis Lu. All rights reserved.
//

import UIKit
import Parse

class SettingViewController: UIViewController {

    @IBOutlet weak var buttonLogout: UIButton!
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.title = "Setting"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buttonLogout.layer.cornerRadius = 10.0
        buttonLogout.clipsToBounds = true
        
    }

    @IBAction func pushLogout(sender: AnyObject) {
        PFUser.logOut()
        performSegueWithIdentifier("segueToLogin", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func websitePressed(sender: AnyObject) {
        // launch web site
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.2020smartventures.com")!)
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
