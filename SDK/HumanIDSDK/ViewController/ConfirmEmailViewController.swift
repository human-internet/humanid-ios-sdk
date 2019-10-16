//
//  ConfirmEmailViewController.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 15/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit

class ConfirmEmailViewController: UIViewController {

    @IBOutlet weak var headerView: HeaderView!
    
    convenience init() {
        self.init(nibName: "ConfirmEmailViewController", bundle: Bundle.humanID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
