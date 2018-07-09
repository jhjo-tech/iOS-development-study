//
//  ViewController.swift
//  ViewControllerCodeAndStoryborard
//
//  Created by Jo JANGHUI on 2018. 6. 6..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var numberLabel = UILabel(frame: CGRect(x: (view.frame.maxX / 2) - 60, y: view.center.y - 180, width: 120, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberLabel.text = "0"
        numberLabel.textAlignment = .center
        numberLabel.backgroundColor = .black
        numberLabel.textColor = .white
        view.addSubview(numberLabel)
    }
    
    // Stroyboard에서 second의 indentifier를 사용해서 접근
    @IBAction private func showSecondView(_ : UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let showSecondView = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        
        present(showSecondView, animated: true)
    }
}

