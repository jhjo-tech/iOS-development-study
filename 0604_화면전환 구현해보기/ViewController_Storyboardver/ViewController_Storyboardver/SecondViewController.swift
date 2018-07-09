//
//  SecondViewController.swift
//  ViewController_Storyboardver
//
//  Created by Jo JANGHUI on 2018. 6. 4..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func unwindToSecondView(_ sender: UIStoryboardSegue) {
        let sourceSecondViewColtroller = sender.source
    }


}
