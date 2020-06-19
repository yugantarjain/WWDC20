// This is miscellanious code including some global variables and an extension to UIViewController.

import UIKit

let w = 600     //width
let h = 750     //height
var round = 1   //rounds of mockstock

extension UIViewController {
    
    func presentInFullScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
    
    func customHeadLabel(_ text: String) -> UILabel {
        let headLabel = UILabel()
        headLabel.text = text
        headLabel.font = UIFont.systemFont(ofSize: 40)
        headLabel.frame = CGRect(x: 20, y: 0, width: w, height: 90)
        headLabel.textColor = .white
        
        return headLabel
    }
    
    func customBottomToolbar(setTintColor setToWhite: Bool = true) -> UIToolbar {
        let toolbar = UIToolbar()
        if setToWhite == true {
            toolbar.tintColor = UIColor.white
        }
        toolbar.frame = CGRect(x: 0, y: 700, width: w, height: 50)
        toolbar.barStyle = .black
        return toolbar
    }
    
}




