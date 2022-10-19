//
//  MyPointViewController.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/19.
//

import UIKit

class MyPointDetailViewController: UIViewController {

    @IBOutlet weak var pointLabel: UILabel!
    
    var point: MyPoint = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
}
