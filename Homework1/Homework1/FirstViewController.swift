
import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBAction func buttonClicked(sender: AnyObject) {
        TODO1()
        if (age.text=="") {
            println("You must enter Age!")
        }
        else {
            TODO2()
            TODO3()
            TODO4()
        }
        
    }
    
    func TODO1 () {
        label.text="Hello world!"
    }
    
    func TODO2 () {
        println("Hello " + name.text + ", you are " + age.text + " years old!")
    }
    
    func TODO3 () {
        var ageString:String=age.text

            var ageInt:Int=ageString.toInt()!
            if (ageInt > 21) {
                println("You can drink")
            }
            else if (ageInt > 18) {
                println("You can vote")
            }
            else if (ageInt > 16) {
                println("You can drive")
            }
        }
    
    
    func TODO4 () {
        var ageString:String=age.text
        var ageInt:Int=ageString.toInt()!
        if (ageInt > 21) {
            println("You can drive, vote and drink but not at the same time")
        }
        else if (ageInt > 18) {
            println("You can drive and vote")
        }
        else if (ageInt > 16) {
            println("You can drive")
        }
    }


  /*
  TODO one: hook up a button in interface builder to a new function (to be written) in this class. Also hook up the label to this class. When the button is clicked, the function to be written must make a label say ‘hello world!’
  
  TODO two: Connect the ‘name’ and ‘age’ text boxes to this class. Hook up the button to a NEW function (in addition to the function previously defined). That function must look at the string entered in the text box and print out “Hello {name}, you are {age} years old!”
  TODO three: Hook up the button to a NEW function (in addition to the two above). Print “You can drink” below the above text if the user is above 21. If they are above 18, print “you can vote”. If they are above 16, print “You can drive”
  TODO four: Hook up the button to a NEW function (in additino to the three above). Print “you can drive” if the user is above 16 but below 18. It should print “You can drive and vote” if the user is above 18 but below 21. If the user is above 21, it should print “you can drive, vote and drink (but not at the same time!”.
  */
}
