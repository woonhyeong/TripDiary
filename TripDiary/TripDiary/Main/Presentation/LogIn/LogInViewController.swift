//
//  LogInViewController.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/10.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class LogInViewController: UIViewController, StoryboardInstantiable {
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var findPasswordButton: UIButton!
    @IBOutlet private weak var confirmButton: UIButton!
    
    private var loginTextFieldView = LogInTextFieldView.instanceFromNib!
    private var passwordTextFieldView = LogInTextFieldView.instanceFromNib!
    
    public var disposeBag = DisposeBag()
    public var completionCallback: ((CompletionType) -> Void)?
    
    public enum CompletionType {
        case loginComplete
    }
}

// MARK: - ViewController Life Cycle
extension LogInViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavigationBar()
        bindInit()
        addTapGesture()
        
        if reactor == nil {
            reactor = LogInReactor()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        resetUI()
    }
}

// MARK: - ReactorKit
extension LogInViewController: StoryboardView {
    typealias Reactor = LogInReactor
    
    func bind(reactor: LogInReactor) {
        reactor.state.map { $0.event }
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .loggedIn:
                    print("===> Success Log In.")
                    self?.completionCallback?(.loginComplete)
                case .apiError:
                    print("===> API Error.")
                case .nothing:
                    print("===> Nothing.")
                }
            }).disposed(by: disposeBag)
    }
}

// MARK: - Binding
extension LogInViewController {
    private func bindInit() {
        loginTextFieldView.didEditingChanged.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.loginTextFieldView.state = .normal
            }).disposed(by: disposeBag)
        
        passwordTextFieldView.didEditingChanged.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.passwordTextFieldView.state = .normal
            }).disposed(by: disposeBag)
    }
}

// MARK: - Set up UI
extension LogInViewController {
    private func resetUI() {
        self.navigationController?.navigationBar.isHidden = false
        loginTextFieldView.reset()
        passwordTextFieldView.reset()
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }

    private func setupUI() {
        self.view.backgroundColor = .mainGreen
        
        loginTextFieldView.placeholder = "UserID"
        loginTextFieldView.normalStateColor = .white
        loginTextFieldView.invalidStateColor = .red
        loginTextFieldView.invalidStateGuideText = "올바른 아이디를 입력하세요"
        
        passwordTextFieldView.isPassword = true
        passwordTextFieldView.placeholder = "Password"
        passwordTextFieldView.normalStateColor = .white
        passwordTextFieldView.invalidStateColor = .red
        passwordTextFieldView.invalidStateGuideText = "올바른 비밀번호를 입력하세요"
        
        stackView.addArrangedSubview(loginTextFieldView)
        stackView.addArrangedSubview(passwordTextFieldView)
        
        confirmButton.layer.cornerRadius = 14.0
        confirmButton.addTarget(self, action: #selector(confirmButtonTouched(_:)), for: .touchUpInside)
    
        findPasswordButton.addTarget(self, action: #selector(findPasswordButtonTouched(_:)), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        self.title = "로그인"
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
        let loginId = loginTextFieldView.text
        let password = passwordTextFieldView.text
        
        loginTextFieldView.state = loginId.isEmpty ? .empty : .normal
        passwordTextFieldView.state = password.isEmpty ? .empty : .normal
        
        if loginId.isEmpty || password.isEmpty { return }
        
        // Todo: Action event - login
        reactor?.action.onNext(.signInUser(id: loginId, password: password))
    }
    
    @objc private func findPasswordButtonTouched(_ sender: UIButton) {
        // Todo: Routing to find password viewcontroller
        self.navigationController?.pushViewController(FindPasswordViewController.instantiate(), animated: true)
    }
}
