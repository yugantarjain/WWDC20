// This is the introduction screen, welcoming the user with the main title, purpose, and a custom live star background.
// The star background has been designed to reflect the real world experience of looking up to the stars in the sky, with more and more stars becoming visible each moment along with twinkling.

import UIKit
import SpriteKit
import Foundation

public class IntroViewController : UIViewController {
    
    private let stack = UIStackView()
    
    override public func viewDidAppear(_ animated: Bool) {
        //show stack (headlabel and sublabel) every time view appears
        stack.alpha = 1
    }
    
    override public func viewDidLoad() {
        
        //Initialise view
        let view = UIView()
        view.backgroundColor = .black
        
        //Configure head label
        let headLabel = UILabel()
        headLabel.text = "MOCK STOCK"
        headLabel.font = UIFont.systemFont(ofSize: 52)
        headLabel.textColor = .white
        headLabel.sizeToFit()
        
        //Configure subtitle label
        let subLabel = UILabel()
        subLabel.text = "for Planet Earth"
        subLabel.font = UIFont.systemFont(ofSize: 28)
        subLabel.textColor = .white
        subLabel.sizeToFit()
        
        //Stack for two labels
        stack.axis = .vertical
        stack.addArrangedSubview(headLabel)
        stack.addArrangedSubview(subLabel)
        stack.frame.size = headLabel.frame.size
        stack.frame.size.height += subLabel.frame.size.height
        stack.center = CGPoint(x: w/2, y: h/2)
        
        //Next button for toolbar
        let nextButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fastForward, target: self, action: #selector(nextVC))
        
        //Bottom toolbar
        let toolbar = customBottomToolbar(setTintColor: false)
        toolbar.setItems([nextButton], animated: false)
        
        //Rendering of views
        view.addSubview(starView())
        view.addSubview(stack)
        view.addSubview(toolbar)
        self.view = view
    }
    
    //star background view
    func starView() -> UIView {
        let starView = UIView()
        starView.frame.size = CGSize(width: w, height: 750)
        
        let sk = SKView()
        sk.frame = starView.bounds
        sk.backgroundColor = .clear
        starView.addSubview(sk)
        
        let scene: SKScene = SKScene(size: starView.bounds.size)
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .clear
        
        if let en = SKEmitterNode(fileNamed: "Stars.sks") {
            en.position = sk.center
            en.zPosition = -1
            scene.addChild(en)
        }
        
        sk.presentScene(scene)
        
        return starView
    }
    
    @objc private func nextVC() {
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            //fade out the stack (headlabel and sublabel) with animation
            self.stack.alpha = 0
        }, completion: { (UIViewAnimatingPosition) in
            self.presentInFullScreen(FeaturedStocksViewController(), animated: true)
        })
        
    }
    
}
