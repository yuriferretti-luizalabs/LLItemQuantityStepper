
//
//  ItemQuantityStepper.swift
//  Stepper Teste
//
//  Created by Yuri Ferretti on 4/10/17.
//  Copyright © 2017 yuri. All rights reserved.
//

import UIKit

open class LLItemQuantityStepper: UIView {
    
    private let decreaseButton = UIButton()
    private let increaseButton = UIButton()
    private let currentValueLabel = UILabel()
    private let stackView = UIStackView()
    public typealias RemoveBlock = ((Void) -> Void)
    open var removeBlock: RemoveBlock?
    
    open override var tintColor: UIColor! {
        didSet {
            layer.borderColor = tintColor.cgColor
            increaseButton.setTitleColor(tintColor, for: .normal)
            decreaseButton.setTitleColor(tintColor, for: .normal)
            currentValueLabel.textColor = tintColor
        }
    }
    
    private var _currentValue: Int = 0 {
        didSet {
           updateUIForValue(_currentValue)
        }
    }
    
    
    open var currentValue: Int {
        get {
            return _currentValue
        }
        set {
            if newValue < minimumValue {
                _currentValue = minimumValue
            } else if newValue > maximumValue {
                _currentValue = maximumValue
            } else {
                _currentValue = newValue
            }
        }
    }
    
    
    open var minimumValue: Int = 0 {
        didSet {
            if _currentValue < minimumValue {
                _currentValue = minimumValue
            }
        }
    }
    
    open var maximumValue: Int = 10 {
        didSet {
            if _currentValue > minimumValue {
                _currentValue = minimumValue
            }
        }
    }
    
    open var increaseLabel: String = "+" {
        didSet {
            increaseButton.setTitle(increaseLabel, for: .normal)
        }
    }
    
    open var decreaseLabel: String = "-" {
        didSet {
            decreaseButton.setTitle(decreaseLabel, for: .normal)
        }
    }
    
    open var removeImage: UIImage? {
        didSet {
            updateUIForValue(_currentValue)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        [decreaseButton, currentValueLabel, increaseButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.stackView.addArrangedSubview($0)
        }
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.setTitleColor(.black, for: .normal)
        decreaseButton.setTitleColor(.lightGray, for: .disabled)
        increaseButton.setTitle("+", for: .normal)
        increaseButton.setTitleColor(.black, for: .normal)
        increaseButton.setTitleColor(.lightGray, for: .disabled)
        currentValue = 0
        currentValueLabel.textColor = .darkText
        currentValueLabel.textAlignment = .center
        layer.cornerRadius = 12
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        
        let increase = #selector(LLItemQuantityStepper.increaseValue)
        let decrease = #selector(LLItemQuantityStepper.decreaseValue)
        
        increaseButton.addTarget(self, action: increase, for: .touchUpInside)
        decreaseButton.addTarget(self, action: decrease, for: .touchUpInside)
    }
    
    private func updateUIForValue(_ value: Int) {
        currentValueLabel.text = String(describing: _currentValue)
        increaseButton.isEnabled = (_currentValue < maximumValue)
        
        if value == minimumValue, let image = removeImage {
            decreaseButton.setTitle(nil, for: .normal)
            decreaseButton.setImage(image, for: .normal)
        } else {
            decreaseButton.setTitle(decreaseLabel, for: .normal)
            decreaseButton.setImage(nil, for: .normal)
        }
        
    }
    
    open func increaseValue() {
        let newValue = _currentValue + 1
        guard newValue <= maximumValue else {
            return
        }
        _currentValue = newValue
    }
    
    open func decreaseValue() {
        let newValue = _currentValue - 1
        if newValue == (minimumValue - 1) {
            removeBlock?()
            return
        }
        if newValue < minimumValue {
            return
        } else if newValue == minimumValue {
            updateUIForValue(newValue)
            
        }
        _currentValue = newValue
    }
}
