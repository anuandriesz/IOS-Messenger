//
//  ViewController.swift
//  Messenger
//
//  Created by Anuradha Andriesz on 2022-06-20.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")

        if !isUserLoggedIn {
            let vc = LoginViewController()
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            present(nc, animated: false)
            //self.show(nc, sender: nil)
        }
    }
}

