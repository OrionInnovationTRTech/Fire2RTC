//
//  LoginViewController.swift
//  fire2RTC
//
//  Created by Ece Ayvaz on 25.01.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func didTapLogin() {
        let storyboard =  UIStoryboard(name: "MainViewController", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as MainViewController? else { return  }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        loginViewModel.didTapLogin = self.didTapLogin
        loginViewModel.loginUser(userEmail: emailTextField.text, userPassword: passwordTextField.text)
    }
}
