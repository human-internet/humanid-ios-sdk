import UIKit

protocol OTPCodeViewDelegate {

    func didFinishInput(_ inputView: OTPCodeView, didFinishWith text: String)
}

class OTPCodeView: UIControl, UIKeyInput {

    override var canBecomeFirstResponder : Bool {
        return true
    }

    var hasText : Bool {
        return nextTag == 1 ? true : false
    }

    var inputColor: UIColor = UIColor.black{
        didSet{
            self.borderColor = inputColor
        }
    }

    var numberOfPin: Int = 4{
        didSet{
            print(numberOfPin)
        }
    }

    var keyboardType: UIKeyboardType {
        get{
            return .numberPad
        }
        set{
        }
    }

    var activeFieldColor:UIColor?
    var codeText = ""
    var borderRadius: CGFloat?
    var stackView:UIStackView!
    var delegate: OTPCodeViewDelegate?
    var isSecureTextEntry = false
    var borderColor: UIColor!
    var views = [UIView]()

    private var boxSize: CGSize!
    private var nextTag = 1

    init(
        numberOfPin: Int, inputColor:UIColor = .black ,
        font: UIFont = UIFont.systemFont(ofSize: 15),
        boxSize:CGSize = .init(width: 40, height: 40),
        textColor: UIColor = .white,
        spacing:CGFloat = 15,
        activeFieldColor: UIColor = .clear, backgroundClr: UIColor = .clear
    ){
        super.init(frame: UIScreen.main.bounds)
        self.boxSize = boxSize
        self.borderRadius = boxSize.height / 2
        self.activeFieldColor = activeFieldColor
        self.numberOfPin = numberOfPin
        self.inputColor = activeFieldColor

        borderColor = inputColor

        for index in 1...numberOfPin{
            let v = UIView(frame: CGRect(x: 0, y: 0, width: boxSize.width, height: boxSize.height + 4))
            v.heightAnchor.constraint(equalToConstant: boxSize.height + 4).isActive = true
            v.widthAnchor.constraint(equalToConstant: boxSize.height).isActive = true

            let lbl = UILabel()
            lbl.font = .systemFont(ofSize: 42)
            lbl.tag = index
            lbl.backgroundColor = backgroundClr
            lbl.font = font
            lbl.textAlignment = .center
            lbl.text = ""
            lbl.textColor = .black
            lbl.font = .systemFont(ofSize: 42)
            lbl.translatesAutoresizingMaskIntoConstraints = false

            let bottomBorder = UIView(frame: CGRect(x: 0, y: boxSize.height + 2, width: boxSize.width, height: 2))
            bottomBorder.backgroundColor = .gray

            v.addSubview(bottomBorder)
            v.addSubview(lbl)

            lbl.heightAnchor.constraint(equalToConstant: boxSize.height).isActive = true
            lbl.widthAnchor.constraint(equalToConstant: boxSize.width).isActive = true

            bottomBorder.heightAnchor.constraint(equalToConstant: 2).isActive = true
            bottomBorder.widthAnchor.constraint(equalToConstant: boxSize.width).isActive = true

            lbl.topAnchor.constraint(equalTo: v.topAnchor).isActive = true
            lbl.leadingAnchor.constraint(equalTo: v.leadingAnchor).isActive = true
            lbl.trailingAnchor.constraint(equalTo: v.trailingAnchor).isActive = true

            bottomBorder.bottomAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
            bottomBorder.leadingAnchor.constraint(equalTo: v.leadingAnchor).isActive = true
            bottomBorder.trailingAnchor.constraint(equalTo: v.trailingAnchor).isActive = true

            views.append(v)
        }

        stackView = UIStackView(arrangedSubviews: views)

        addSubview(stackView)
        stackView.spacing = spacing
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.anchorTo(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: nil)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func insertText(_ text: String) {
        if nextTag <= numberOfPin {
            let tagLabel = self.viewWithTag(nextTag) as? UILabel
            changeStyle(for: tagLabel!, type: 1)
            animateLabelChange(for: tagLabel!, to: text)

            if (nextTag == 1){
                codeText = tagLabel?.text ?? ""
            } else {
                codeText += tagLabel?.text ?? ""
            }

            if isSecureTextEntry == true {
                animateLabelChange(for: tagLabel!, to: "\u{2022}")
            }

            nextTag += 1

            if nextTag == numberOfPin + 1{
                delegate?.didFinishInput(self, didFinishWith: codeText)
            }
        }
    }

    func deleteBackward() {
        if nextTag > 1 {
            nextTag -= 1
            let tagLabel = self.viewWithTag(nextTag) as? UILabel

            animateLabelChange(for: tagLabel!, to: "")
            changeStyle(for: tagLabel!, type: 0)
            codeText = String(codeText.dropLast())
        }
    }

    private func animateLabelChange(for label: UILabel, to text: String){
        UIView.transition(
            with: label,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                label.text = text
            }, completion: nil
        )
    }

    private func changeStyle(for label:UILabel, type: Int){
        switch (type) {
        case (0):
            label.backgroundColor = .clear
            label.layer.borderWidth = 0.0
            label.layer.borderColor = UIColor.clear.cgColor
            label.layer.cornerRadius =  0
        default:
            label.backgroundColor = .clear
            label.textColor = .black
            label.layer.borderWidth = 0.0
            label.layer.borderColor = UIColor.clear.cgColor
            label.layer.cornerRadius =  0
        }
    }
}
