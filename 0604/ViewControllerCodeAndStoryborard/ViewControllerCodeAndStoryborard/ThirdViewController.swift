//
//  ThirdViewController.swift
//  ViewControllerCodeAndStoryborard
//
//  Created by Jo JANGHUI on 2018. 6. 6..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    lazy var countButton = UIButton(frame: CGRect(x: (view.frame.maxX / 2) - 60, y: view.center.y - 180, width: 120, height: 50))
    
    lazy var currentValue = UIButton(frame: CGRect(x: (view.frame.maxX / 2) - 60, y: view.center.y - 100, width: 120, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countButton.backgroundColor = .white
        countButton.setTitle("COUNT", for: .normal)
        countButton.setTitleColor(.red, for: .normal)
        countButton.addTarget(self, action: #selector(showViewAndCount(_:)), for: .touchUpInside)
        view.addSubview(countButton)
        
        currentValue.backgroundColor = .red
        currentValue.setTitleColor(.white, for: .normal)
        currentValue.setTitle("Count의 결과값", for: .normal)
        view.addSubview(currentValue)
    }
    
    // ViewContoller에 있는 label에 값을 넣어주는 function
    func viewCountTextLabel () {
        guard let viewCounter = self.presentingViewController?.presentingViewController as? ViewController, let text = viewCounter.numberLabel.text, let count = Int(text) else { return }
        
        viewCounter.numberLabel.text = "\(count + 1)"
        self.currentValue.setTitle("\(count + 1)", for: .normal)
    }
    
    // alert을 사용해서 ViewController에 있는 label에 값을 넣어줄건지를 물어봅니다.
//    @objc private func showViewAndCount (_ : UIButton) {
//        let showAlert = UIAlertController(title: "카운터를 하시겠습니까?", message: nil, preferredStyle: .alert)
//
//        let alertOk = UIAlertAction(title: "OK", style: .default) { (_) in
//            self.viewCountTextLabel()
//        }
//
//        let alertCansel = UIAlertAction(title: "Cansel", style: .cancel) { (_) in
//        }
//
//        for idx in [alertOk, alertCansel] {
//            showAlert.addAction(idx)
//        }
//        self.present(showAlert, animated: true)
//
//    }
    
    
    @objc private func showViewAndCount (_ : UIButton) {
        let showAlert = UIAlertController(title: "카운터를 하시겠습니까?", message: nil, preferredStyle: .alert)
        
        showAlert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
            self.viewCountTextLabel()

        })
        
        showAlert.addAction(UIAlertAction(title: "Cansel", style: .cancel) { (_) in
        })
//        for idx in [alertOk, alertCansel] {
//            showAlert.addAction(idx)
//        }
        self.present(showAlert, animated: true)
        
    }
    
    // Back Button을 누르면 해당 페이지를 제거합니다.
    @IBAction private func thirdDismiss (_ sender: Any) {
        dismiss(animated: true)
    }
    
    // third view가 제거되면 출력
    deinit{
        print("Third view Deinit")
    }

}
