//
//  CallViewController.swift
//  Covid-19-Demo
//
//  Created by MacBook on 3/26/20.
//  Copyright © 2020 MacBookSafwen. All rights reserved.
//

import UIKit

class CallViewController: UIViewController {

    @IBOutlet weak var imageCall: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func callGreenNumber(_ sender: Any) {
        if let url = URL(string: "tel://80 10 19 19"),
        UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func callAction(_ sender: Any) {
        if let url = URL(string: "tel://190"),
        UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
