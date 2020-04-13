import Foundation

class HeaderView: UIView {

    @IBOutlet var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }

    func customInit() {
        guard let humanIDBundle = Bundle.humanID else {
            print("bundle not found")
            return
        }

        humanIDBundle.loadNibNamed("HeaderView", owner: self, options: nil)

        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
