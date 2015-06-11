
import UIKit

class SecondViewController: UIViewController {
  
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBAction func buttonClicked(sender: AnyObject) {
        var textString:String=text.text
        var textInt:Int=textString.toInt()!
        var labelString:String=label.text!
        var labelInt:Int=labelString.toInt()!
        
        var sum:Int=textInt+labelInt
        
        label.text=String(sum)
    }
  //TODO five: Display the cumulative sum of all numbers added every time the ‘add’ button is pressed. Hook up the label, text box and button to make this work.
}
