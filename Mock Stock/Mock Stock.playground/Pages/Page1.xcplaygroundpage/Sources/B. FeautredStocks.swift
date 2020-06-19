// This screen shows the 4 featured stocks. With the stocks being astronomical bodies, they are shown to be rotating continuously using animations.
// The speed of rotation for each body has been kept different to roughly mimic their actual rotational speed comparison.

import UIKit

public class FeaturedStocksViewController: UIViewController {
    var images = [UIImageView]()

    public override func viewDidLoad() {
        
        //Four featured stocks
        let stockNames = ["Earth", "Mars", "Moon", "Kepler-452b"]
        
        //Main view
        let mainView = UIView()
        mainView.backgroundColor = UIColor(white: 0, alpha: 1)
        
        //views
        let headLabel = customHeadLabel("Featured Stocks")
        var names = [UILabel]()
        var stockViews = [UIView]()
        
        //Spacing and side value
        let gap = 5
        let side = (w-(gap*3))/2
        
        //Placing of 4 stocks in 2*2 layout
        for i in 0...3
        {
            names.append(UILabel())
            names[i].text = stockNames[i]
            names[i].textColor = UIColor.init(white: 1, alpha: 0.9)
            names[i].font = UIFont.systemFont(ofSize: 20)
            names[i].sizeToFit()
            names[i].center = CGPoint(x: side/2, y: 25)
            
            images.append(UIImageView())
            images[i].image = UIImage(named: stockNames[i])
            images[i].frame = CGRect(x: side/8, y: 60, width: 3*side/4, height: 3*side/4)
            
            stockViews.append(UIView())
            stockViews[i].frame = CGRect(x: gap+((gap+side)*(i%2)), y: 90+gap+((i/2)*(gap+side)), width: side, height: side)
            stockViews[i].backgroundColor = UIColor(white: 1, alpha: 0.05)
            stockViews[i].addSubview(names[i])
            stockViews[i].addSubview(images[i])
                        
            mainView.addSubview(stockViews[i])
        }
        
        //Buttons for bottom toolbar
        let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.rewind, target: self, action: #selector(prevVC))
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 30
        let nextButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fastForward, target: self, action: #selector(nextVC))
        
        //Bottom toolbar
        let toolbar = customBottomToolbar()
        toolbar.setItems([backButton, space, nextButton], animated: true)
        
        //Rendering of views
        mainView.addSubview(headLabel)
        mainView.addSubview(toolbar)
        self.view = mainView
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        for i in 0...3 {
            rotateWithAnimation(images[i], Double(i))
        }
    }
    
    @objc private func nextVC() {
        presentInFullScreen(GeneralRulesViewController(), animated: true)
    }
    
    //Previous view controller
    @objc private func prevVC() {
        dismiss(animated: false) {
        }
    }
    
    private func rotateWithAnimation(_ view: UIImageView, _ i: Double) { 
        let animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: i*10 + 130, delay: 0, options: .curveLinear, animations: {
            
            UIView.animateKeyframes(withDuration: 0, delay: 0, animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0 / 3.0) {
                    view.transform = .init(rotationAngle: .pi * 2 * 1 / 3)
                }

                UIView.addKeyframe(withRelativeStartTime: 1.0 / 3.0, relativeDuration: 1.0 / 3.0) {
                    view.transform = .init(rotationAngle: .pi * 2 * 2 / 3)
                }

                UIView.addKeyframe(withRelativeStartTime: 2.0 / 3.0, relativeDuration: 1.0 / 3.0) {
                    view.transform = .identity
                }
                
            })
            
        }, completion: { (UIViewAnimatingPosition) in
            self.rotateWithAnimation(view, i)
        })
        animator.startAnimation()
    }
    
}


