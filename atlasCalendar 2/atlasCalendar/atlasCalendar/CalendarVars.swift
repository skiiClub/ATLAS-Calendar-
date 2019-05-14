
import Foundation


var date = Date()
var calendar = Calendar.current

var day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date)
//do -1 here. 13:58
var month = calendar.component(.month, from: date)-1
var year = calendar.component(.year, from: date)


