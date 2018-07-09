//
//  ViewController.swift
//  ViewController_Storyboardver
//
//  Created by Jo JANGHUI on 2018. 6. 4..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func unwindToView(_ sender: UIStoryboardSegue) {
        let sourceViewColtroller = sender.source
    }
    
}

