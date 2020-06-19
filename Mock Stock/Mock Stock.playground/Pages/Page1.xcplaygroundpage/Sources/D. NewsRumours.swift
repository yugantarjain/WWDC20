// In this screen, the news and rumours for each stock are shown to the user.
// With the playground aiming to propagate awareness for our environment, the news and rumours have been formulated after thorough research to reflect real data and facts.

import UIKit

var stockFlow = [UIColor.white, UIColor.white, UIColor.white, UIColor.white]    //colors as per stock trend

public class NewsAndRumoursViewController: UIViewController {
    
    override public func viewDidLoad() {
        let stockNames = ["Earth","Mars","Moon","Kepler-452b"]
        let newsAndRumours = [["Earth is the only planet known to harbour life on its surface. Earth boasts of a robust self-sustaining ecosystem with a suitable atmosphere for life to grow, millions of different species of various forms and large quantities of liquid water.", "Human beings, who form the most advanced species living on Earth have made strides in science and technology throughout the years. However, humanity’s callous approach has damaged their planet severely leading to degradation of its environment across all domains.", "Human beings on Earth have continued to ignore the effects of their actions and have done little to improve their functioning as a civilisation. Earth’s ecosystem is now critically damaged and life has begun to disappear from it with thousands of species already extinct and others on the verge of it."], ["Mars is the fourth planet from the sun in the same solar system as Earth. Known as the Red Planet due to the reddish iron oxide prevalent on its surface, Mars also contains a large amount of water on its surface but only in frozen form.", "With continuous degradation of planet Earth, humanity is now looking out for other planets and astronomical bodies to colonise. Mars, being Earth’s immediate neighbour is constantly becoming a potential option.", "Human beings on planet Earth are now constantly working to develop technologies to emigrate their civilisation to Mars. However, Mars’ thin atmosphere, lack of liquid water and oxygen, and low gravity pose major hurdles to this alternative."], ["The Moon is an astronomical body that orbits planet Earth and is Earth's only permanent natural satellite. Moon’s presence is vital to planet Earth as it helps in maintaining stability in Earth’s climate and create tides in its seas.", "Human beings from Earth have been able to send several manned missions to Moon successfully with the development of technology. However, the lack of atmosphere and extremely low gravity makes life impossible on it.", "With the Earth’s ecosystem breaking down, human beings on Earth are desperately looking for other astronomical bodies to colonise having Mars as their prime option. However, Moon may still be seen as a backup option being previously visited by humans."], ["Kepler-452b is an exoplanet (planet outside our solar system) in the constellation Cygnus. Given the name of Earth’s bigger cousin, Kepler-452b is believed to be extremely similar to planet Earth suggesting high chances of life’s existence on it.", "Earth’s bigger cousin which has extremely high chances of supporting life on its surface is found to be much older than Earth in age. This suggests that life there may be even more advanced than on Earth.", "Kepler 452-b is 1400 light years away from Earth making it irrelevant to human beings despite its composition and life supporting conditions."]]
        
        let view = UIView()
        view.backgroundColor = .black
        
        let headLabel = customHeadLabel("News and Rumours (Round \(round))")
        
        //Stack for news and rumours
        let stack = UIStackView()
        stack.frame = CGRect(x: 0, y: 70+25, width: w, height: 630-50)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5
        
        //views
        var stock = [UIView]()              //view, to be added to stack
        var nameLabel = [UILabel]()         //label for name of stock
        var priceLabel = [UILabel]()        //label for share price
        var stockImage = [UIImageView]()    //image of stock(planet)
        var desc = [UITextView]()           //text view to display news and rumour
        
        //Configuring and adding views to stack.
        for i in 0...3
        {
            nameLabel.append(UILabel())
            nameLabel[i].text = stockNames[i]
            nameLabel[i].textColor = UIColor.white
            nameLabel[i].sizeToFit()
            nameLabel[i].frame.origin = CGPoint(x: w/4, y: 10)
            
            priceLabel.append(UILabel())
            priceLabel[i].text = "$\(sharePrices[i])"
            priceLabel[i].textColor = stockFlow[i]
            priceLabel[i].sizeToFit()
            priceLabel[i].frame.origin = CGPoint(x: 4*w/5, y: 10)
            
            stockImage.append(UIImageView())
            stockImage[i].image = UIImage(named: stockNames[i])
            stockImage[i].frame = CGRect(x: 15, y: 15, width: 120, height: 120)
            
            desc.append(UITextView())
            desc[i].text = newsAndRumours[i][round-1]
            desc[i].font = UIFont.systemFont(ofSize: 15)
            desc[i].frame = CGRect(x: 150, y: 30, width: w-150, height: 140)
            desc[i].frame.origin = CGPoint(x: 150, y: 30)
            desc[i].isEditable = false
            desc[i].backgroundColor = nil
            desc[i].textColor = UIColor.init(white: 1, alpha: 0.9)
            
            stock.append(UIView())
            stock[i].backgroundColor = UIColor.init(white: 1, alpha: 0.1)
            stock[i].addSubview(nameLabel[i])
            stock[i].addSubview(priceLabel[i])
            stock[i].addSubview(stockImage[i])
            stock[i].addSubview(desc[i])
            
            stack.addArrangedSubview(stock[i])
        }
        
        let backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.rewind, target: self, action: nil)
        backButton.isEnabled = false
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 30
        let nextButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fastForward, target: self, action: #selector(nextVC))
        
        let toolbar = customBottomToolbar()
        toolbar.setItems([backButton, space, nextButton], animated: false)
        
        view.addSubview(headLabel)
        view.addSubview(stack)
        view.addSubview(toolbar)
        self.view = view
        
    }
    
    @objc func nextVC() {
        presentInFullScreen(TradingViewController(), animated: false)
    }
}
