import UIKit

open class LLItemQuantityStepper: UIControl {
    
    private let decreaseButton = UIButton()
    private let increaseButton = UIButton()
    private let currentValueLabel = UILabel()
    private let stackView = UIStackView()
    
    open override var tintColor: UIColor! {
        didSet {
            layer.borderColor = tintColor.cgColor
            increaseButton.setTitleColor(tintColor, for: .normal)
            decreaseButton.setTitleColor(tintColor, for: .normal)
            currentValueLabel.textColor = tintColor
        }
    }
    
    open var font: UIFont = .systemFont(ofSize: 15) {
        didSet {
            [currentValueLabel, increaseButton.titleLabel, decreaseButton.titleLabel].forEach {
                $0?.font = font
            }
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
            _currentValue = max(min(newValue, maximumValue), minimumValue)
        }
    }
    
    
    open var minimumValue: Int = 0 {
        didSet {
            if (minimumValue >= 0) && (_currentValue < minimumValue) {
                _currentValue = minimumValue
            }
        }
    }
    
    open var maximumValue: Int = 10 {
        didSet {
            if _currentValue > maximumValue {
                _currentValue = maximumValue
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
        
        decreaseButton.setTitle(decreaseLabel, for: .normal)
        decreaseButton.setTitleColor(.black, for: .normal)
        decreaseButton.setTitleColor(.lightGray, for: .disabled)
        increaseButton.setTitle(increaseLabel, for: .normal)
        increaseButton.setTitleColor(.black, for: .normal)
        increaseButton.setTitleColor(.lightGray, for: .disabled)
        currentValue = 0
        currentValueLabel.textColor = .darkText
        currentValueLabel.textAlignment = .center
        currentValueLabel.isUserInteractionEnabled = false
        layer.cornerRadius = 12
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        
        let increase = #selector(LLItemQuantityStepper.increaseValue)
        let decrease = #selector(LLItemQuantityStepper.decreaseValue)
        
        increaseButton.addTarget(self, action: increase, for: .touchUpInside)
        decreaseButton.addTarget(self, action: decrease, for: .touchUpInside)
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        guard self.point(inside: point, with: event) else {
            return nil
        }
        let buttonThreshold = stackView.bounds.width / 2
        let stackViewPoint = convert(point, to: stackView)
        return (stackViewPoint.x <= buttonThreshold) ? decreaseButton : increaseButton
    }
    
    private func updateUIForValue(_ value: Int) {
        currentValueLabel.text = String(describing: _currentValue)
        let increaseTitleColor = (value == maximumValue) ? .lightGray : tintColor
        increaseButton.setTitleColor(increaseTitleColor, for: .normal)
        
        if value == minimumValue, let image = removeImage {
            decreaseButton.setTitle(nil, for: .normal)
            decreaseButton.setImage(image, for: .normal)
        } else {
            decreaseButton.setTitle(decreaseLabel, for: .normal)
            decreaseButton.setImage(nil, for: .normal)
        }
        
    }
    
    @objc open func increaseValue() {
        let newValue = _currentValue + 1
        guard newValue <= maximumValue else {
            return
        }
        _currentValue = newValue
        sendActions(for: .valueChanged)
        if #available(iOS 10.0, *) {
            selectionChangedFeedback()
        }
    }
    
    @objc open func decreaseValue() {
        let newValue = _currentValue - 1
        guard newValue >= minimumValue else {
            return
        }
        _currentValue = newValue
        sendActions(for: .valueChanged)
        if #available(iOS 10.0, *) {
            selectionChangedFeedback()
        }
    }
    
    @available(iOS 10.0, *)
    private func selectionChangedFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
}
