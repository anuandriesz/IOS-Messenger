//
//  LoginViewController.swift
//  Messenger
//
//  Created by Anuradha Andriesz on 2022-06-20.
//

import UIKit

class LoginViewController: UIViewController {
    
    //creating a scrollerview Item
    private let uiScrollerView: UIScrollView = {
        var scrollerView = UIScrollView()
        scrollerView.clipsToBounds = true
        return scrollerView
    }()
    
    //creating a image item
    private let uiImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "logo.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //create a textField
    private let uiTextViewEmail:UITextField = {
        var textView = UITextField()
        textView.autocapitalizationType = .none
        textView.autocorrectionType =  .no
        textView.returnKeyType = .continue // user press on tab android --> cursor jump to next
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.placeholder = "Email"
        textView.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textView.leftViewMode = .always
        return textView
    }()
    
    private let uiTextViewPassword:UITextField = {
        var textView = UITextField()
        textView.autocapitalizationType = .none
        textView.autocorrectionType =  .no
        textView.returnKeyType = .done
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.placeholder = "Password"
        textView.isSecureTextEntry = true
        textView.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textView.leftViewMode = .always
        return textView
    }()
    
    private let uiButton:UIButton = {
        var button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true //cut out the extra corners
        button.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style:.done, target: self, action:#selector(self.rightBarButtonDidTouch(_:)))
        
        uiButton.addTarget(self,
                           action: #selector(Self.loginButtonTapped),
                           for: .touchUpInside)
        
        //make the form nicer by implementing tab actions
        uiTextViewEmail.delegate = self
        uiTextViewPassword.delegate = self
        
        
        view.addSubview(uiScrollerView)
        uiScrollerView.addSubview(uiImageView)
        uiScrollerView.addSubview(uiTextViewEmail)
        uiScrollerView.addSubview(uiTextViewPassword)
        uiScrollerView.addSubview(uiButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // width and other imprtent properties calculated using an extention function.
        //Resourcess -> Extention.swift
        uiScrollerView.frame = view.bounds
        let size = uiScrollerView.width/2
        let x = (uiScrollerView.width - size)/2
        uiImageView.frame = CGRect(x: x,
                                   y: 25,
                                   width: size,
                                   height: 50)
        uiTextViewEmail.frame = CGRect(x: 30,
                                       y: uiImageView.bottom+50,
                                       width: uiScrollerView.width-60,
                                       height: 52)
        
        uiTextViewPassword.frame = CGRect(x: 30,
                                          y: uiTextViewEmail.bottom+10,
                                          width: uiScrollerView.width-60,
                                          height: 52)
        
        uiButton.frame = CGRect(x: 30,
                                y: uiTextViewPassword.bottom+10,
                                width: uiScrollerView.width-60,
                                height: 52)
    }
    
    @objc func rightBarButtonDidTouch(_ sender:UIBarButtonItem!)
    {
        let vc = RegistrationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func loginButtonTapped(){
        
        //remove keboard
        uiTextViewEmail.resignFirstResponder()
        uiTextViewPassword.resignFirstResponder()
        
        //validations
        guard let email = uiTextViewEmail.text , let password = uiTextViewPassword.text,
              !email.isEmpty,!password.isEmpty, password.count >= 6 else {
                  showLoginErrorMessage()
                  return
        }
        
        //Implement firbase login
    }
    
    
    private func showLoginErrorMessage(){
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all infomations to log in.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert,animated: true)
    }
}

//write an extention function to navigate through items
extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == uiTextViewEmail {
            uiTextViewPassword.becomeFirstResponder()
        } else if textField == uiTextViewPassword {
            loginButtonTapped()
        }
        return true
    }
}
