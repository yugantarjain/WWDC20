// This screen shows the general rules of the game to the user.

import UIKit

public class GeneralRulesViewController: UIViewController {
    
    private let rules = ["There will be 3 rounds in this mock stock.", "In each round, you will be given news and rumours regarding each stock.", "Depending upon the news and rumours, the price of each stock will be updated at the end of each round.", "You have to buy and sell shares of the featured stocks to maximise your profit.", "Shares of a particular stock can either be bought or sold in a particular round.", "Shares can be sold and bought only in multiples of 100.", "The software has been built in a way to make any invalid transaction impossible.", "All the best!"]
    
    public override func viewDidLoad() {
        
        let view = UIView()
        view.backgroundColor = .black
        
        let headLabel = customHeadLabel("General Rules")
        
        //Text view to display rules
        let rulesTextView = UITextView()
        rulesTextView.font = UIFont.systemFont(ofSize: 20)
        rulesTextView.isEditable = false
        for rule in rules
        {
            rulesTextView.text.append(rule)
            rulesTextView.text.append("\n\n")
        }
        rulesTextView.frame = CGRect(x: 20, y: 115, width: w-40, height: h-230)
        rulesTextView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
        
        let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.rewind, target: self, action: #selector(prevVC))
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 30
        let nextButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fastForward, target: self, action: #selector(nextVC))
        
        let toolbar = customBottomToolbar()
        toolbar.setItems([backButton, space, nextButton], animated: false)
        
        view.addSubview(headLabel)
        view.addSubview(rulesTextView)
        view.addSubview(toolbar)
        self.view = view
    }
    
    @objc private func nextVC() {
        presentInFullScreen(NewsAndRumoursViewController(), animated: true)
    }
    
    @objc private func prevVC() {
        dismiss(animated: false) {
        }
    }
}

