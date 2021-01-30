//
//  FindPasswordViewController.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/17.
//

import UIKit
import RxSwift
import RxCocoa

class FindPasswordViewController: UIViewController, StoryboardInstantiable {
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var confirmButton: UIButton!
    
    private var idTextFieldView = LogInTextFieldView.instanceFromNib!
    
    public var disposeBag = DisposeBag()
}

// MARK: - ViewController Life Cycle
extension FindPasswordViewController {
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
extension FindPasswordViewController {
    private func bindInit() {
        idTextFieldView.didEditingChanged.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.idTextFieldView.state = .normal
            }).disposed(by: disposeBag)
    }
}

// MARK: - Set up UI
extension FindPasswordViewController {
    private func resetUI() {
        self.navigationController?.navigationBar.isHidden = false
        idTextFieldView.reset()
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
                
        stackView.addArrangedSubview(idTextFieldView)
        
        confirmButton.layer.cornerRadius = 14.0
        confirmButton.addTarget(self, action: #selector(confirmButtonTouched(_:)), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        self.title = "비밀번호 찾기"
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
        
        idTextFieldView.state = loginId.isEmpty ? .empty : .normal
        
        if loginId.isEmpty { return }
        
        // Todo: Action event - login
    }
}
