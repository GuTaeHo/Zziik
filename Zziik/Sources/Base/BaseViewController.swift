//
//  BaseViewController.swift
//  blossom
//
//  Created by 구태호 on 2022/06/25.
//

import UIKit
import SnapKit
import Combine


class BaseViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initAttributes()
        initAction()
        binding()
    }
    
    func initViews() { }
    func initAttributes() { }
    func initAction() { }
    func binding() { }
}
