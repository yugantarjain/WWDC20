// This is the final page thanking the user for taking out the time and learning about the environmental cause.

import UIKit

public class FinalPageViewController: UIViewController {
    public override func loadView() {
        modalTransitionStyle = .partialCurl
    }
    public override func viewDidLoad() {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
        
        let thankYouLabel = UILabel()
        thankYouLabel.text = "Thank You"
        thankYouLabel.textColor = #colorLiteral(red: 0.150000006, green: 0.150000006, blue: 0.150000006, alpha: 1)
        thankYouLabel.font = UIFont.systemFont(ofSize: 76)
        thankYouLabel.sizeToFit()
        
        let earth = UIImageView()
        earth.image = UIImage(named: "Earth")
        earth.frame.size.height = thankYouLabel.frame.size.height
        earth.frame.size.width = thankYouLabel.frame.size.height
        
        //placing of views (label and image)
        let spacing: CGFloat = 12
        let requiredWidth = thankYouLabel.frame.size.width + earth.frame.size.width + spacing
        thankYouLabel.frame.origin.x = (CGFloat(w) - requiredWidth)/2
        thankYouLabel.center.y = CGFloat(h/2)
        earth.frame.origin.x = thankYouLabel.frame.maxX + spacing
        earth.center.y = CGFloat(h/2)
        
        //rendering
        view.addSubview(thankYouLabel)
        view.addSubview(earth)
        self.view = view
    }
}
