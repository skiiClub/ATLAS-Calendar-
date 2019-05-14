

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    

    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var MonthLabel: UILabel!
  
    
    
    
    //Initial variables for setup
    
    let Months = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let DaysOfMonth = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var DaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var currentMonth = String()
    
    var  NumberOfEmptyBox = Int() //The number of "empty boxes"
    
    var nextNumberOfEmptyBox = Int() //The same with above but with the next month
    
    var PreviousNumberOfEmptyBox = 0 // The same with above withthe previous month
    
    var Direction = 0 // =0 if we are at the current month, 1 if we are in a future month, -1 if we are in a previous month
    
    var PositionIndex = 0 //here we wil lstore the above vars of the empty boxes

    var LeapyearCounter = 1 //its 2 because the next time Febuary has 29 days is in two years (it happens every 4 years
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        currentMonth = Months[month]
        
        MonthLabel.text = "\(currentMonth) \(year)"
        
     
    }

    
    @IBAction func Next(_ sender: Any) {
        switch currentMonth{
        case "December":
            month = 0
            year += 1
            Direction = 1
            
            if LeapyearCounter < 5{
                LeapyearCounter += 1
            }
            
            if LeapyearCounter == 4{
                DaysInMonth[1] = 29
            }
            
            if LeapyearCounter == 5{
                LeapyearCounter = 1
                DaysInMonth[1] = 28
            }
            
            
            
            
            
            
            
            GetStartDateDayPosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        default:
            Direction = 1
            GetStartDateDayPosition()
            month += 1
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    
    @IBAction func Back(_ sender: Any) {
        switch currentMonth{
        case "January":
            month = 11
            year -= 1
            Direction = -1
            
            if LeapyearCounter > 0{
                LeapyearCounter -= 1
            }
            
            if LeapyearCounter == 0{
                DaysInMonth[1] = 29
                LeapyearCounter = 4
            }
            else{
                DaysInMonth[1] = 28
            }
            
            GetStartDateDayPosition()
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        default:
            month -= 1
            Direction = -1
            
            GetStartDateDayPosition()
            
            
            currentMonth = Months[month]
            MonthLabel.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
    func GetStartDateDayPosition(){
        switch Direction{
        case 0:
            switch day{
            case 1...7:
                NumberOfEmptyBox = weekday - day
            case 8...14:
                NumberOfEmptyBox = weekday - day - 7
            case 15...21:
                NumberOfEmptyBox = weekday - day - 14
            case 22...28:
                NumberOfEmptyBox = weekday - day - 21
            case 29...31:
                NumberOfEmptyBox = weekday - day - 28
            default:
                break
            }
            PositionIndex = NumberOfEmptyBox
        case 1...:
            nextNumberOfEmptyBox = (PositionIndex + DaysInMonth[month])%7
            PositionIndex = nextNumberOfEmptyBox
        
        case -1:
            PreviousNumberOfEmptyBox = (7 - (DaysInMonth[month] - PositionIndex)%7)
            if PreviousNumberOfEmptyBox == 7{
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }



    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction{
        case 0:
            return DaysInMonth[month] + NumberOfEmptyBox
        case 1...:
            return DaysInMonth[month] + nextNumberOfEmptyBox
        case -1:
            return DaysInMonth[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        
        cell.backgroundColor = UIColor.clear
        
        cell.DateLabel.textColor = UIColor.black
        
        
       
        if cell.isHidden == true{
            cell.isHidden = false
        }
        switch Direction{
        case 0:
               cell.DateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox)"
        case 1:
            cell.DateLabel.text = "\(indexPath.row + 1 - nextNumberOfEmptyBox)"
        case -1:
            cell.DateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.DateLabel.text!)! < 1{
            cell.isHidden = true
        }
        
        //show the weekenddays in different color
        switch indexPath.row{
        case 5,6,12,13,19,20,26,27,33,34: //indexes of the collectionView that matches the weekend slots
            if Int(cell.DateLabel.text!)! > 0{
                cell.DateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day{
            cell.backgroundColor = UIColor.red
        }
        
        return cell
    
    }

}

