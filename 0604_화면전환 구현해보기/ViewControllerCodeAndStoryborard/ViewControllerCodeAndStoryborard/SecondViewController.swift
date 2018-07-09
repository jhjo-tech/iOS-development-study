//
//  SecondViewController.swift
//  ViewControllerCodeAndStoryborard
//
//  Created by Jo JANGHUI on 2018. 6. 6..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

final class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // storyboard의 indentifier을 사용해서 thirdView에 접근
    @IBAction private func showThirdView (_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let showThirdView = storyboard.instantiateViewController(withIdentifier: "ThirdViewController")
        
        present(showThirdView, animated: true)
    }
    
    // modal의 옵션별로 동작하는 걸 알고싶어서 버튼을 여러개 만들었습니다.
    @IBAction private func showViewPartialCurl (_ : UIButton) {
        modalTransitionStyle = .partialCurl
        dismiss(animated: true)
    }
    
    @IBAction private func showViewCoverVertical (_ : UIButton) {
        modalTransitionStyle = .coverVertical
        dismiss(animated: true)
    }
    
    @IBAction private func showViewflipHorizontal (_ : UIButton) {
        modalTransitionStyle = .flipHorizontal
        dismiss(animated: true)
    }
    
    @IBAction private func showVeiwCrossDissolve (_ : UIButton) {
        modalTransitionStyle = .crossDissolve
        dismiss(animated: true)
    }

    

}
