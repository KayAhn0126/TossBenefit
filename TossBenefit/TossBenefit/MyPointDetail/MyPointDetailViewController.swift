//
//  MyPointViewController.swift
//  TossBenefit
//
//  Created by Kay on 2022/10/19.
//

import UIKit
import Combine

class MyPointDetailViewController: UIViewController {
    
    @IBOutlet weak var pointLabel: UILabel!
    
    var viewModel: MyPointDetailViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func bind() {
        viewModel.$point
            .receive(on: RunLoop.main)
            .sink { point in
                self.pointLabel.text = "\(point.point) 원"
            }.store(in: &subscriptions)
    }
}
