//
//  ViewController.swift
//  Display
//
//  Created by Jo JANGHUI on 2018. 5. 29..
//  Copyright © 2018년 jhDAT. All rights reserved.
//
/*
 색상을 가진 화면을 디바이스의 가장 큰 화면부터 15point씩 작아게나 만들고, 디바이스를 바꿔도 같은 결과가 나오게 만드세요.
 */
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 최종완성된 좌우 15씩 작아지며, 원하는 색상을 넣어서 만들수 있습니다.
        let baseView = view.frame
        
        func changeScreenSize (from frame: CGRect) -> CGRect {
            return CGRect(x: frame.minX + 15, y: frame.minY + 15, width: frame.width - 30, height: frame.height - 30)
        }
        
        func setViewColor (with frame: CGRect, color: UIColor) -> UIView {
            let view = UIView(frame: changeScreenSize(from: frame))
            view.backgroundColor = color
            return view
        }
        
        let redView = setViewColor(with: changeScreenSize(from: baseView), color: .red)
        view.addSubview(redView)
        
        let greenView = setViewColor(with: changeScreenSize(from: redView.frame), color: .green)
        view.addSubview(greenView)
        
        /*
        // func을 이용해서 만들기 위해 view.frame크기와 redView.frame크기 확인
        let baseFrame = view.frame  // 뷰의 모든 프레임크기
        print(view.frame)           // (0.0, 0.0, 375.0, 812.0) Points
        
        let redView = UIView(frame: CGRect(x: baseFrame.minX + 30, y: baseFrame.minY + 30, width: baseFrame.width - 60, height: baseFrame.height - 60))
        redView.backgroundColor = .red
        view.addSubview(redView)
        print(redView.frame)        // (30.0, 30.0, 315.0, 752.0) points
        */
        
        
        /*
        //처음 만든 코드. 2개를 만들때는 좋지만 비슷한걸 여러개 만들때는 하나하나 다 설정해 줘야 해서 힘들것 같습니다.
        let redView = UIView(frame: CGRect(x: 30, y: 30, width: view.frame.width - 60, height: view.frame.height - 60))
        redView.backgroundColor = .red
        view.addSubview(redView)
        
        let greenView = UIView(frame: CGRect(x: 60, y: 60, width: view.frame.width - 120, height: view.frame.height - 120))
        greenView.backgroundColor = .green
        view.addSubview(greenView)
         */
    }

}

