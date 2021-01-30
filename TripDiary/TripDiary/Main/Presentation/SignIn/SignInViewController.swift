//
//  SignInViewController.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/17.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController, StoryboardInstantiable {
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var confirmButton: UIButton!
    
    private var idTextFieldView = LogInTextFieldView.instanceFromNib!
    private var passwordTextFieldView = LogInTextFieldView.instanceFromNib!
    private var passwordConfirmTextFieldView = LogInTextFieldView.instanceFromNib!
    
    public var disposeBag = DisposeBag()
}

// MARK: - ViewController Life Cycle
extension SignInViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavigationBar()
        bindInit()
        addTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetUI()
    }
}


// MARK: - Binding
extension SignInViewController {
    private func bindInit() {
        idTextFieldView.didEditingChanged.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.idTextFieldView.state = .normal
            }).disposed(by: disposeBag)
        
        passwordTextFieldView.didEditingChanged.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.passwordTextFieldView.state = .normal
            }).disposed(by: disposeBag)
        
        passwordConfirmTextFieldView.didEditingChanged.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.passwordConfirmTextFieldView.state = .normal
            }).disposed(by: disposeBag)
    }
}

// MARK: - Set up UI
extension SignInViewController {
    private func resetUI() {
        self.navigationController?.navigationBar.isHidden = false
        idTextFieldView.reset()
        passwordTextFieldView.reset()
        passwordConfirmTextFieldView.reset()
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }

    private func setupUI() {
        self.view.backgroundColor = .mainGreen
        
        idTextFieldView.placeholder = "UserID"
        idTextFieldView.normalStateColor = .white
        idTextFieldView.invalidStateColor = .red
        idTextFieldView.invalidStateGuideText = "올바른 아이디를 입력하세요"
        
        passwordTextFieldView.isPassword = true
        passwordTextFieldView.placeholder = "Password"
        passwordTextFieldView.normalStateColor = .white
        passwordTextFieldView.invalidStateColor = .red
        passwordTextFieldView.invalidStateGuideText = "올바른 비밀번호를 입력하세요"
        
        passwordConfirmTextFieldView.isPassword = true
        passwordConfirmTextFieldView.placeholder = "Password Confirm"
        passwordConfirmTextFieldView.normalStateColor = .white
        passwordConfirmTextFieldView.invalidStateColor = .red
        passwordConfirmTextFieldView.invalidStateGuideText = "비밀번호가 일치하지 않습니다"
        
        stackView.addArrangedSubview(idTextFieldView)
        stackView.addArrangedSubview(passwordTextFieldView)
        stackView.addArrangedSubview(passwordConfirmTextFieldView)
        
        confirmButton.layer.cornerRadius = 14.0
        confirmButton.addTarget(self, action: #selector(confirmButtonTouched(_:)), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        self.title = "회원가입"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20.0, weight: .regular)]
        
        let backButton = UIBarButtonItem(image: UIImage(assetIdentifier: .leftBackButton), style: .plain, target: self, action: #selector(navigationBackButtonTouched(_:)))
        self.navigationItem.leftBarButtonItem = backButton
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.mainGreen
    }
    
    @objc private func navigationBackButtonTouched(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func confirmButtonTouched(_ sender: UIButton) {
        let loginId = idTextFieldView.text
        let password = passwordTextFieldView.text
        let passwordConfirm = passwordConfirmTextFieldView.text
        
        idTextFieldView.state = loginId.isEmpty ? .empty : .normal
        passwordTextFieldView.state = password.isEmpty ? .empty : .normal
        passwordConfirmTextFieldView.state = passwordConfirm.isEmpty ? .empty : .normal
        
        if loginId.isEmpty || password.isEmpty
            || passwordConfirm.isEmpty { return }
        
        if password != passwordConfirm {
            passwordConfirmTextFieldView.state = .invalid
        }
        
        // Todo: Action event - login
    }
}
