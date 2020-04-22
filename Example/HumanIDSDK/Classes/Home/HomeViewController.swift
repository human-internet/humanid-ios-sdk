import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!

    var exchangeToken = ""
    var userHash = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        messageLabel.text = "Your token is\n\(exchangeToken)\n\nWith registered device hash:\n\(userHash)"
    }
}
