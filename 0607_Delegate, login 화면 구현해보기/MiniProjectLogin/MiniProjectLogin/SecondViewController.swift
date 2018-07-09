//
//  SecondViewController.swift
//  MiniProjectLogin
//
//  Created by Jo JANGHUI on 2018. 6. 7..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    let textLabel = UILabel()
    
    @IBAction private func secondViewDismiss () {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textLableCGRect = CGRect(x: 0 , y: view.center.y - 50, width: view.frame.maxX, height: 50)
        textLabel.frame = textLableCGRect
        if let userName = UserDefaults.standard.object(forKey: "userName") as? String {
            textLabel.text = ("\(userName)님 환영합니다.")
        }
        textLabel.textColor = .black
        textLabel.font = UIFont.systemFont(ofSize: CGFloat(25))
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
        
        
    }

    

}
