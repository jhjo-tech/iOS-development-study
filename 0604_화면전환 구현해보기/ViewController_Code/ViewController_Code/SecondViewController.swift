//
//  SecondViewController.swift
//  ViewController_Code
//
//  Created by Jo JANGHUI on 2018. 6. 4..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    lazy var nextButton = UIButton(frame: CGRect(x: view.frame.maxX - 100, y: view.frame.minY + 50, width: 80, height: 30))
    lazy var backButton = UIButton(frame: CGRect(x: view.frame.minX + 30, y: view.frame.minY + 50, width: 80, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        nextButton.backgroundColor = .black
        nextButton.setTitle("NEXT >", for: .normal)
        nextButton.addTarget(self, action: #selector(thirdView(_:)), for: .touchUpInside)
        view.addSubview(nextButton)
        
        backButton.backgroundColor = .black
        backButton.setTitle("< BACK", for: .normal)
        backButton.addTarget(self, action: #selector(unWindToView(_:)), for: .touchUpInside)
        view.addSubview(backButton)
    }

    @objc private func thirdView (_ : UIViewController) {
        let thirdViewController = ThirdViewController()
        present(thirdViewController, animated: true)
    }
    
    // dimiss는 ViewController에 의해 modally로 표시된 View Controller을 닫습니다.
    // 현제 뷰를 닫아서 이전 뷰를 보여준다.
    @objc private func unWindToView (_ : UIViewController) {
        dismiss(animated: true)
    }
    
    // 완전 제거되면 "second View deinit" 출력
    deinit {
        print("second View deinit")
    }
}
