//
//  ConfirmEmailViewController.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 15/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import UIKit

class ConfirmEmailViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    
    convenience init() {
        self.init(nibName: "ConfirmEmailViewController", bundle: Bundle(identifier: "org.humanid.HumanIDSDK"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let contentHeaderView = HeaderView(frame: headerView.frame)
        headerView.addSubview(contentHeaderView)
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
