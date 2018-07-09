//
//  UserInfoEnter.swift
//  MiniProjectLogin
//
//  Created by Jo JANGHUI on 2018. 6. 7..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit



class UserInfoEnter: ViewController, UITextFieldDelegate {
    
    let userNameField = UITextField()
    let passwordField = UITextField()
    let userImg = UIImageView(image: #imageLiteral(resourceName: "userIcon"))
    let passImg = UIImageView(image: #imageLiteral(resourceName: "passwordIcon"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ViewController - userEnterView
        let userEnterViewCGRect = CGRect(x: 0, y: view.frame.maxY - 300, width: view.frame.maxX, height: 300)
        super.userEnterView.frame = userEnterViewCGRect
        userEnterView.backgroundColor = .white
        view.addSubview(userEnterView)
        
        
        // UITextFieldDelegate
        userNameField.delegate = self
        passwordField.delegate = self
        
        // UserName Text Field
        let userNameCGRect = CGRect(x: 80, y: 15, width: userEnterView.frame.maxX - 100, height: 30)
        userNameField.frame = userNameCGRect
        userNameField.backgroundColor = .white
        userNameField.placeholder = "이름을 입력하세요."
        userNameField.borderStyle = .roundedRect
        userNameField.clearButtonMode = .always
        super.userEnterView.addSubview(userNameField)
        
        // Password Text Field
        let passwordCGRect = CGRect(x: userNameField.frame.origin.x , y: userNameField.frame.origin.y + 40, width: userEnterView.frame.maxX - 100, height: 30)
        passwordField.frame = passwordCGRect
        passwordField.backgroundColor = .white
        passwordField.placeholder = "비밀번호를 입력하세요."
        passwordField.borderStyle = .roundedRect
        passwordField.clearButtonMode = .always
        passwordField.isSecureTextEntry = true // 텍스트 복사를 막고 텍스트를 숨김
        super.userEnterView.addSubview(passwordField)
        
        // Login Button
        let loginButton = UIButton(frame: CGRect(x: 0, y: userEnterView.frame.height - 40, width: userEnterView.frame.maxX, height: 40))
        loginButton.backgroundColor = UIColor(red: 0.107, green: 0.628, blue: 0.990, alpha: 1.0)
        loginButton.setTitle("LogIn", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(userInfoCheck), for: .touchUpInside)
        super.userEnterView.addSubview(loginButton)
        
        userImg.frame = CGRect(x: userNameField.frame.minX - 50, y: userNameField.frame.minY, width: 28, height: 28)
        super.userEnterView.addSubview(userImg)
        
        passImg.frame = CGRect(x: passwordField.frame.minX - 50, y: passwordField.frame.minY, width: 28, height: 28)
        super.userEnterView.addSubview(passImg)
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        super.userEnterView.frame.origin.y = view.frame.maxY - 400
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        super.userEnterView.frame.origin.y = view.frame.maxY - 300
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
    }
    
    // User Information Check
    @objc private func userInfoCheck () {
        let stringUserName = self.userNameField.text ?? ""
        let stringPassword = self.passwordField.text ?? ""
        
        if self.userNameField.text?.isEmpty == true && self.userNameField.text?.isEmpty == true {
            let alert = UIAlertController(title: "정보를 입력해주세요", message: nil, preferredStyle: .alert)
            let alertOK = UIAlertAction(title: "OK", style: .default) { (_) in }
            alert.addAction(alertOK)
            present(alert, animated: true)
        } else if stringUserName == userIdentifier.userName,
            stringPassword == userIdentifier.password {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let showSecondView = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
            present(showSecondView, animated: true)
            // User name save
            UserDefaults.standard.set(stringUserName, forKey: "userName")
            // TextField empty
            userNameField.text = ""
            passwordField.text = ""
        } else {
            let alert = UIAlertController(title: "회원이름 또는 비빌번호를 확인해주세요", message: nil, preferredStyle: .alert)
            let alertOK = UIAlertAction(title: "OK", style: .default) { (_) in
                self.userNameField.text = nil;
                self.passwordField.text = nil
            }
            let alertCancel = UIAlertAction(title: "Calcel", style: .cancel) { (_) in
                self.userNameField.text = ""
                self.passwordField.text = ""
            }

            for idx in [alertOK, alertCancel] { alert.addAction(idx) }
            present(alert, animated: true)
        }
        
        
    }
   
}
