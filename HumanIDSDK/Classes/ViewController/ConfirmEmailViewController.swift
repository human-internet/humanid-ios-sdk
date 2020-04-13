import UIKit

class ConfirmEmailViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var headerView: HeaderView!

    var clientName = ""
    var email = ""

    convenience init(email: String, clientName: String) {
        self.init(nibName: "ConfirmEmailViewController", bundle: Bundle.humanID)
        self.clientName = clientName
        self.email = email
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = "Yes, I can access & recall\n\(email)\nin case I have to recover my humanID login in the future"

        finishButton.setTitle("FINISH SIGN UP & RETURN TO\n\(clientName)", for: .normal)
        finishButton.titleLabel?.textAlignment = .center

        containerView.layer.cornerRadius = 10
        backButtonView.layer.cornerRadius = 5
        finishButton.layer.cornerRadius = 5
    }

    @IBAction func finishButtonAction(_ sender: Any) {
    }

    @IBAction func backButtonAction(_ sender: Any) {
    }
}
