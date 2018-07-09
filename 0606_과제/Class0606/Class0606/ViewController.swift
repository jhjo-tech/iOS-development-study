//
//  ViewController.swift
//  Class0606
//
//  Created by Jo JANGHUI on 2018. 6. 6..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit



final class ViewController: UIViewController, UITextFieldDelegate, TextSendDelegate {

    

    //UITextField는 1줄
    lazy var enterTextField = UITextField(frame: CGRect(x: view.center.x - 190, y: view.frame.minY + 120, width: 380, height: 50))
    
    lazy var viewTextLabel = UILabel(frame: CGRect(x: view.center.x - 190, y: view.frame.minY + 50, width: 380, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.803, green: 0.972, blue: 0.771, alpha: 1.0)
        
        self.enterTextField.delegate = self
        enterTextField.borderStyle = .roundedRect
        enterTextField.textColor = .black
        enterTextField.tintColor = .red      // 입력창 커서의 색
        enterTextField.textAlignment = .center
        enterTextField.text = "Please Enter Text -"
        enterTextField.textColor = .gray
        view.addSubview(enterTextField)
        
        viewTextLabel.text = "Label"
        viewTextLabel.textAlignment = .center
        viewTextLabel.font = UIFont.systemFont(ofSize: 27)
        view.addSubview(viewTextLabel)
        
        let nextButton = UIButton(frame: CGRect(x: view.center.x - 190, y: view.frame.minY + 200, width: 380, height: 50))
        
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        nextButton.setTitle("TEXT Send Next View >", for: .normal)
        nextButton.setTitleColor(.blue, for: .normal)
        nextButton.addTarget(self, action: #selector(showNextViewAndSendText(_:)), for: .touchUpInside)
        view.addSubview(nextButton)

        let clearButton = UIButton(frame: CGRect(x: enterTextField.frame.maxX - 20, y: view.frame.minY + 120, width: 20, height: 50))
        
        clearButton.setTitle("<", for: .normal)
        clearButton.setTitleColor(.gray, for: .normal)
        clearButton.backgroundColor = .clear
        clearButton.addTarget(self, action: #selector(textFieldClear(_:)), for: .touchUpInside)
        view.addSubview(clearButton)
        
        
        // Mark: Delegate Button
        let button = CoustomSendButton(frame: CGRect(x: view.center.x - 190, y: view.frame.minY + 300, width: 380, height: 50))
        
        button.delegate = self
        view.addSubview(button)
    }
    
    // 시작시 텍스트 필드 초기화
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.enterTextField.text = nil
    }
    
    // 입력하면서 텍스트 필드의 내용을 레이블로 보내고, 글자색도 blue로 변경
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        // 2개는 같은 문장입니다.
        if textField.text != nil { self.viewTextLabel.text = String(textField.text!) + string }
//        let text = (textField.text ?? "") + string
//        self.textLabel.text = text
        
        self.enterTextField.textColor = .blue       // 입력되는 문자 색 변경
        self.viewTextLabel.textColor = .blue        // 입력되는 문자가 표시되는 색 변경
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.enterTextField.text = "Please Enter Text -" 
        self.viewTextLabel.textColor = .red
        
        textField.resignFirstResponder()    // textField.resignFirstResponder() 있어야 키보드가 사라집니다.
        return true
    }
    
    
    @objc private func textFieldClear ( _ : UIButton) {
        self.enterTextField.text = nil
        self.viewTextLabel.text = "Label"
    }
    
    @objc private func showNextViewAndSendText (_ : UIButton) {
        if self.viewTextLabel.text != nil {
            TextField.shared.textField.text = String(self.viewTextLabel.text!)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let showSecondView = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        
        present(showSecondView, animated: true)
    }
    
    //Delegate를 만들어서 동작 
    func textSend() {
        TextField.shared.textField.text = self.viewTextLabel.text ?? ""
        print("textSend")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let showSecondView = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        present(showSecondView, animated: true)
    }

}

