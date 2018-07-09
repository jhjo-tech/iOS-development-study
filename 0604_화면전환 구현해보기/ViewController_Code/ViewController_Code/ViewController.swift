//
//  ViewController.swift
//  ViewController_Code
//
//  Created by Jo JANGHUI on 2018. 6. 4..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // view.frame. 을 사용하기 위해서 lazy를 사용했습니다.
    lazy var nextButton = UIButton(frame: CGRect(x: view.frame.maxX - 100, y: view.frame.minY + 50, width: 80, height: 30))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        nextButton.setTitle("NEXT>", for: .normal)
        nextButton.backgroundColor = .black
        nextButton.addTarget(self, action: #selector(secondView(_:)), for: .touchUpInside)
        view.addSubview(nextButton)
        
        
    }
    
    // Second View를 띄워주는 함수입니다.
    @objc private func secondView (_ : UIViewController) {
        let secondViewController = SecondViewController()
        
        present(secondViewController, animated: true)
    }




}

