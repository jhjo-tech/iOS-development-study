//
//  0528ViewControllerMission.swift
//  Class0528
//
//  Created by Jo JANGHUI on 2018. 5. 28..
//  Copyright © 2018년 jhDAT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var button1Count: Int = 0
    var button2Count: Int = 0
    var buttonColorInitCount: Int = 0
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var buttonColorInit: UIButton!
    
    @IBAction func button1Action(_ sender: Any) {
        button2.backgroundColor = UIColor.black
        button1Count += 1
        button1.setTitle("1번 버튼 클릭 횟수는: \(String(button1Count))", for: .normal )
    }
    
    @IBAction func button2Action(_ sender: Any) {
        button1.backgroundColor = UIColor.red
        button2Count += 1
        button2.setTitle("2번 버튼 클릭 횟수는: \(String(button2Count))", for: .normal )
    }
    
    @IBAction func buttonColorInitAction(_ sender: Any) {
        button2.backgroundColor = UIColor.clear
        button1.backgroundColor = UIColor.clear
        buttonColorInitCount += 1
        buttonColorInit.setTitle("초기화 버튼 클릭 횟수는: \(String(buttonColorInitCount))", for: .normal )
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        print("ViewController view Did load")
        
        // Do any additional setup after loading the view, typically from a nib.
        button1.setTitle("1번 버튼", for: .normal)
        button2.setTitle("2번 버튼", for: .normal)
        button2.setTitleColor(UIColor.orange, for: .normal)
    }
    
    
}

