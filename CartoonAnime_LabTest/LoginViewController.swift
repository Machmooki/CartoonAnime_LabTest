//
//  LoginViewController.swift
//  CartoonAnime_LabTest
//
//  Created by Mach Suwanpatikorn on 23/11/2569 BE.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Cartoon Anime"
        titleLabel.font = AppFont.medium(32)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true

        logoImageView.image = UIImage(named: "dragon_ball")
        logoImageView.contentMode = .scaleAspectFit

        for field in [usernameTextField, passwordTextField] {
            field?.textColor = .black
            field?.font = AppFont.regular(14)
            field?.autocapitalizationType = .none
            field?.autocorrectionType = .no
            field?.delegate = self
        }
        usernameTextField.placeholder = "username"
        passwordTextField.placeholder = "password"
        passwordTextField.isSecureTextEntry = true
        usernameTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .go
    }

    @IBAction func loginTapped(_ sender: Any) {
        view.endEditing(true)
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let password = passwordTextField.text ?? ""

        guard let account = UserStore.authenticate(username: username, password: password) else {
            let alert = UIAlertController(title: "Sign In ไม่สำเร็จ",
                                          message: "username หรือ password ไม่ถูกต้อง",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ตกลง", style: .default))
            present(alert, animated: true)
            return
        }

        UserStore.saveLogin(account)
        passwordTextField.text = ""
        performSegue(withIdentifier: "showMainMenu", sender: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            loginTapped(textField)
        }
        return true
    }
}
