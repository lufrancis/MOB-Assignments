
import UIKit

class ThirdViewController: UIViewController {
  
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBAction func CalculateClicked(sender: AnyObject) {
        var numberString:String=number.text
        var numberInt:Int=numberString.toInt()!
        
        if ((numberInt % 2) == 0) {
            label.text="This is even"
        }
        else {
            label.text="This is not even"
        }
    }
    /*
  TODO six: Hook up the number input text field, button and text label to this class. When the button is pressed, a message should be printed to the label indicating whether the number is even.
  
  */
}
