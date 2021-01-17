//
//  LogInTextFieldView.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/13.
//

import UIKit
import RxSwift
import RxCocoa

public final class LogInTextFieldView: UIView, InstantiableFromNib {
    public enum State {
        case empty
        case invalid
        case normal
    }
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var guideLabel: UILabel!
    
    public lazy var didEditingChanged = self.textField.rx.controlEvent([.editingChanged]).asDriver()
    
    public var state: State = .normal {
        didSet {
            applyCurrentState()
        }
    }
    
    public var text: String {
        return textField.text ?? ""
    }
    
    public var placeholder: String? {
        didSet {
            applyCurrentState()
        }
    }
    
    public var isPassword: Bool = false {
        didSet {
            textField.isSecureTextEntry = isPassword
        }
    }

    public var invalidStateGuideText: String? {
        didSet {
            applyCurrentState()
        }
    }
    
    public var normalStateColor: UIColor = .white {
        didSet {
            applyCurrentState()
        }
    }
    public var invalidStateColor: UIColor = .red {
        didSet {
            applyCurrentState()
        }
    }
    
    private func applyCurrentState() {
        switch state {
        case .normal:
            textField.textColor = normalStateColor
            separatorView.backgroundColor = normalStateColor
            guideLabel.textColor = normalStateColor
            guideLabel.text = ""
            
            if let placeholderString = placeholder {
                textField.attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [.font: UIFont.systemFont(ofSize: 20.0, weight: .regular),
                                                                                                             .foregroundColor: UIColor.white])
            }
            
        case .empty:
            textField.textColor = invalidStateColor
            separatorView.backgroundColor = invalidStateColor
            guideLabel.textColor = invalidStateColor
            guideLabel.text = invalidStateGuideText
            
            if let placeholderString = placeholder {
                textField.attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [.font: UIFont.systemFont(ofSize: 20.0, weight: .regular),
                                                                                                             .foregroundColor: UIColor.red])
            }

        case .invalid:
            textField.textColor = invalidStateColor
            separatorView.backgroundColor = invalidStateColor
            guideLabel.textColor = invalidStateColor
            guideLabel.text = invalidStateGuideText
            
            if let placeholderString = placeholder {
                textField.attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [.font: UIFont.systemFont(ofSize: 20.0, weight: .regular),
                                                                                                             .foregroundColor: UIColor.red])
            }
        }
    }
}

extension LogInTextFieldView {
    public override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
