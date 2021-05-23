import UIKit

class LabelViewController: UIViewController {

    
    @IBOutlet weak var label_LBL_first: UILabel!
    @IBOutlet weak var label_LBL_second: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label_LBL_first.isCopyingEnabled = true
        
    }
    

}
