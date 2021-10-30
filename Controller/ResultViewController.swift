
import UIKit

class ResultViewController: UIViewController {
    var score : String = "0"
    
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        scoreLabel.text = score
    }
    
    @IBAction func playeAgainPressed(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
