//
//  ThirdViewController.swift
//  ViewController_Code
//
//  Created by Jo JANGHUI on 2018. 6. 4..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    lazy var initButton = UIButton(frame: CGRect(x: view.frame.maxX - 170, y: view.frame.minY + 50, width: 150, height: 30))
    lazy var backButton = UIButton(frame: CGRect(x: view.frame.minX + 30, y: view.frame.minY + 50, width: 80, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        initButton.setTitle("< initButton >", for: .normal)
        initButton.backgroundColor = .black
        initButton.addTarget(self, action: #selector(initView(_:)), for: .touchUpInside)
        view.addSubview(initButton)
        
        backButton.setTitle("< Back", for: .normal)
        backButton.backgroundColor = .black
        backButton.addTarget(self, action: #selector(unWindToSeconVeiw(_:)), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    @objc private func initView (_ : ViewController) {
        let firstViewController = ViewController()
        present(firstViewController, animated: true)
    }
    
    @objc private func unWindToSeconVeiw (_ : ViewController) {
        dismiss(animated: true)
    }

    deinit {
        print("third View Controller deinit")
    }


}
