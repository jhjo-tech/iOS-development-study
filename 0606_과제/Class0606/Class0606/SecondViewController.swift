//
//  SecondViewController.swift
//  Class0606
//
//  Created by Jo JANGHUI on 2018. 6. 6..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class TextField {
    static let shared = TextField()
    var textField = UILabel(frame: CGRect(x: 20, y: 100, width: 380, height: 50))
}

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextField.shared.textField.textAlignment = .center
        TextField.shared.textField.font = UIFont.systemFont(ofSize: 27)
        view.addSubview(TextField.shared.textField)
    }
    
    @IBAction private func dismissSecondView ( _ : UIButton) {
        dismiss(animated: true)
    }
    
    deinit {
        print("Second View Deinit")
    }
}
