//
//  StudentProfileViewController.swift
//  Homework2
//
//  Created by Kannan Chandrasegaran on 25/6/15.
//  Copyright (c) 2015 Kannan Chandrasegaran. All rights reserved.
//

import UIKit

class StudentProfileViewController: UIViewController {
    @IBOutlet weak var labelFirstname: UILabel!

    @IBOutlet weak var labelLastname: UILabel!
    
    @IBOutlet weak var labelAge: UILabel!

    @IBOutlet weak var labelAvgScore: UILabel!
    
    @IBOutlet weak var labelPhone: UILabel!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var firstName = ""
    var lastName = ""
    var age = 0
    var avgScore = 0
    var phoneNumber = 0
    var imageurl = ""
    
  var student:Student = Student()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        labelFirstname.text = firstName
        labelLastname.text = lastName
        labelAge.text = String(age)
        labelAvgScore.text = String (avgScore)
        if phoneNumber == 0 {
            labelPhone.text = ""
        }
        else {
        labelPhone.text = String (phoneNumber)
        }
        let url = NSURL(string: imageurl)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        imageView.image = UIImage(data: data!)
        
    
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
