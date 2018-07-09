//
//  ViewController.swift
//  VendingMachine
//
//  Created by Jo JANGHUI on 2018. 6. 8..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var currentMoney: Int = 0
    
    var cocacolaPrice: Int = 1000
    var ciderPrice: Int = 800
    var cancofferPrice: Int = 1500
    var samdasuPrice: Int = 500
    
    @IBAction func returnButton(_ sender: UIButton) {
        if currentMoney == 0 {
            statusLabel.textColor = .black
            statusLabel.text = "감사합니다."
            valueLabel.text = "또 이용해 주세요."
        } else {
            let alertController = UIAlertController(title: "잔돈이 남았습니다", message: "더 이용하시겠습니까?", preferredStyle: .alert)
            
            let alertOk = UIAlertAction(title: "OK", style: .default) { (_) in }
            let alertCancel = UIAlertAction(title: "안먹어요", style: .cancel) { (_) in
                self.statusLabel.textColor = .black
                self.statusLabel.text = "\(self.currentMoney)이 반환되었습니다."
                self.valueLabel.text = "또 이용해 주세요."
                self.currentMoney = 0
            }
            
            for idx in [alertOk, alertCancel] { alertController.addAction(idx) }
            present(alertController, animated: true)
        }
    }
    
    private func blanceMoney () {
        if currentMoney == 0 {
            valueLabel.text = "감사합니다"
        } else {
            valueLabel.text = "잔돈은 \(currentMoney)원 입니다."
        }
    }
    
    @IBAction func thousandWondButton(_ sender: UIButton) {
        statusLabel.textColor = .black
        statusLabel.text = "어떤걸 드시겠습니까?"
        currentMoney += 1000
        valueLabel.text = "현재 입금된 금액은 \(currentMoney)입니다."
    }
    @IBAction func fivehunderdWonButton(_ sender: UIButton) {
        statusLabel.textColor = .black
        statusLabel.text = "어떤걸 드시겠습니까?"
        currentMoney += 500
        valueLabel.text = "현재 입금된 금액은 \(currentMoney)입니다."
    }
    
    @IBAction func cocacolaButton(_ sender: UIButton) {
        guard currentMoney >= cocacolaPrice else { statusLabel.textColor = .red; statusLabel.text = "금액이 부족합니다."; valueLabel.text = "현재 금액 \(currentMoney)원"; return}
        currentMoney -= cocacolaPrice
        blanceMoney()
        statusLabel.text = "코카콜라 드세요"
    }

    @IBAction func ciderButton(_ sender: UIButton) {
        guard currentMoney >= ciderPrice else { statusLabel.textColor = .red; statusLabel.text = "금액이 부족합니다.";valueLabel.text = "현재 금액 \(currentMoney)원"; return}
        currentMoney -= ciderPrice
        blanceMoney()
        statusLabel.text = "사이다 드세요"
    }
    @IBAction func cancofferButton(_ sender: UIButton) {
        guard currentMoney >= cancofferPrice else { statusLabel.textColor = .red; statusLabel.text = "금액이 부족합니다.";valueLabel.text = "현재 금액 \(currentMoney)원"; return}
        currentMoney -= cancofferPrice
        blanceMoney()
        statusLabel.text = "캔커피 드세요"
    }
    @IBAction func samdasuButton(_ sender: UIButton) {
        guard currentMoney >= samdasuPrice else { statusLabel.textColor = .red; statusLabel.text = "금액이 부족합니다.";valueLabel.text = "현재 금액 \(currentMoney)원"; return}
        currentMoney -= samdasuPrice
        blanceMoney()
        statusLabel.text = "삼다수 드세요"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}

