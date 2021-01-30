//
//  MainViewController.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/09.
//

import UIKit

class MainViewController: UIViewController, StoryboardInstantiable {
    // MARK: - UI Properties
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    public var logInViewController: UIViewController?
    
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
        self.navigationController?.pushViewController(logInViewController ?? LogInViewController.instantiate(), animated: true)
    }
    
    @IBAction func signUpButtonTouched(_ sender: Any) {
        self.navigationController?.pushViewController(SignInViewController.instantiate(), animated: true)
    }
}

extension MainViewController {
    private func setupUI() {
        logInButton.layer.cornerRadius = 14.0
        signUpButton.layer.cornerRadius = 14.0
    }
}
