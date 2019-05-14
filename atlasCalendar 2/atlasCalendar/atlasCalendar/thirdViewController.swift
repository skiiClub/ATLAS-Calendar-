//
//  thirdViewController.swift
//  atlasCalendar
//
//  Created by Chomiak, John Robert on 4/1/19.
//  Copyright © 2019 Chomiak, John Robert. All rights reserved.
//

import UIKit

import WebKit

class thirdViewController: UIViewController{
    
    @IBOutlet weak var webView: WKWebView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let request = URLRequest(url: URL(string: "https://apps.atlas.illinois.edu/ssw_classroom_scheduler/Requests/NewRequest.aspx?calendarId=207&startDate=4%2f1%2f2019+12%3a00%3a00+AM&displayMode=AdHocRequest&rid=8e0d7e55d1f1480f9fd18be35f2555ab")!)
        
        webView?.load(request)
        
    }

    
    
}
