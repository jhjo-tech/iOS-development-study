//
//  ViewController.swift
//  LoginPage0620
//
//  Created by Jo JANGHUI on 2018. 6. 20..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let viewImage = ["FastCampus_Logo-2"]
    let subViewImage = ["userIcon", "passwordIcon"]
    
    let loginView = UIView()            // 로그인 뷰
    let logoImage = UIImageView()       // 로고 이미지
    
    var guide = UILayoutGuide()         // SafeLayout
    
    let userTextField = UITextField()
    let passwordTextField = UITextField()
    
    let loginButton = UIButton()
    
    var topLayoutConstraint: NSLayoutConstraint?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoImage)
        
        addLoginView()
        addLogoImage()
        
        userTextField.delegate = self
        passwordTextField.delegate = self

        addTextFieldImage(imageName: "userIcon", topConstrant: 50, leadContant: 50)
        addTextFieldImage(imageName: "passwordIcon", topConstrant: 100, leadContant: 52)
        addTextField(textField: userTextField, topConstant: 50, leadConstant: 100)
        addTextField(textField: passwordTextField, topConstant: 100, leadConstant: 102)
        
        passwordTextField.isSecureTextEntry = true
        
        addLoginButton()
        
    }
    
    @objc private func actionLoinbutton () {
        print("aaaa")
    }
    
    
    func addLoginButton () {
        loginView.addSubview(loginButton)
        loginButton.backgroundColor = UIColor(red: 0.69, green: 1.0, blue: 1.9, alpha: 1)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        print(passwordTextField.frame.origin.x)
        
        guide = view.layoutMarginsGuide
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        
        loginButton.addTarget(self, action: #selector(actionLoinbutton), for: .touchDragInside)
    }
    
    func addTextField (textField: UITextField, topConstant: CGFloat, leadConstant: CGFloat) {
        
        textField.backgroundColor = .white
        loginView.addSubview(textField)
        textField.placeholder = "텍스트를 입력해주세요"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        guide = view.layoutMarginsGuide
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: loginView.topAnchor, constant: topConstant).isActive = true
        textField.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: leadConstant).isActive = true
        textField.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: topConstant + 28).isActive = true
        
    }
    
    func addTextFieldImage (imageName: String, topConstrant: CGFloat, leadContant: CGFloat) {
        let textFieldImage = UIImageView()
        textFieldImage.image = UIImage(named: imageName)
        loginView.addSubview(textFieldImage)
        textFieldImage.translatesAutoresizingMaskIntoConstraints = false
        textFieldImage.topAnchor.constraint(equalTo: loginView.topAnchor, constant: topConstrant).isActive = true
        textFieldImage.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: leadContant).isActive = true
    }

//    let a = CGFloat()
    func addLoginView () {
        view.addSubview(loginView)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        topLayoutConstraint = loginView.topAnchor.constraint(equalTo: view.topAnchor, constant: 350)
        topLayoutConstraint?.isActive = true
        loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        loginView.frame.size = CGSize(width: view.frame.maxX, height: 200)
    }
    
    func addLogoImage () {
        guide = view.safeAreaLayoutGuide
        logoImage.image = UIImage(named: viewImage[0])
        let size = CGSize(width: 300, height: 80)
        logoImage.frame = CGRect(origin: CGPoint(x: (view.frame.maxX / 2) - (size.width / 2),
                                                 y: view.frame.minY + 100),
                                                 size: size)
    }

}

extension ViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // animation을 사용하고 싶을때.
//        UIView.animate(withDuration: 5.0, animations: {
//            self.loginView.frame.origin.y = (self.view.frame.height / 2) - 100
//        })
//        self.loginView.frame.origin.y = (self.view.frame.height / 2) - 100
        topLayoutConstraint?.constant = (self.view.frame.height / 2) - 100
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        topLayoutConstraint?.constant = 350
        return true
    }
}





