//
//  RSSViewController.swift
//  atlasCalendar
//
//  Created by Chomiak, John Robert on 4/26/19.
//  Copyright © 2019 Chomiak, John Robert. All rights reserved.
//

import UIKit

import WebKit

class RSSViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: URL(string: "https://apps.atlas.illinois.edu/ssw_classroom_scheduler/Calendars/Calendar.aspx?calendarId=207")!)
        
        webView?.load(request)

       
    }



}
