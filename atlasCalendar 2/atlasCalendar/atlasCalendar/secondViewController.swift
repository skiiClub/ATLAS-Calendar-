

import UIKit

class secondViewController: UIViewController {

    
    //this will change the name of each class
    @IBOutlet var classLabels: [UILabel]!
    
    
    
    
    //this will change the color of the button
    @IBOutlet var classViews: [UIView]!
    
    //todo need an array of colors to loop through each time for each slot
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //demo colors 
        for i in 1...4{
        classViews[i].backgroundColor = UIColor.red
        }
        
        classLabels[2].text = "English 200"
        
        
        for i in 8...12{
            classViews[i].backgroundColor = UIColor.green
        }
        
        classLabels[10].text = "Stat 100"
        
        
        
    }



}
