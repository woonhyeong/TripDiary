//
//  LoginViewController.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/09.
//

import UIKit

class LogInViewController: UIViewController {
    // MARK: - UI Properties
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - IBActions
    @IBAction func logInButtonTouched(_ sender: Any) {
    }
    
    @IBAction func signUpButtonTouched(_ sender: Any) {
    }
}

extension LogInViewController {
    private func setupUI() {
        logInButton.layer.cornerRadius = 14.0
        signUpButton.layer.cornerRadius = 14.0
    }
}
