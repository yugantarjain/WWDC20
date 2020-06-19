// This is the main screen featuring the trading of the stocks.
// The playground has been developed in a way that makes any impossible transaction impossible. It also guides the user whenever an invalid transaction is tried to make it more intuitive and simpler to use.

import UIKit

var sharePrices = [1000,1000,1000,1000]     //share prices
var currentNumberOfShares = [0,0,0,0]       //shares held
var buy = [0,0,0,0]                         //shares bought
var sell = [0,0,0,0]                        //shares sold
var cashFlow = [0,0,0,0]                    //flow of cash, price*amount
var initialCash = 1000000                   //money in hand at start of round

public class TradingViewController: UIViewController {
    
    private let stockNames = ["Earth","Mars","Moon","Kepler-452b"]
    private var cashLeft = initialCash
    
    private var tableCellLabel = [UILabel]()        //label for every cell in trading sheet
    
    private var plusButton = [UIButton]()           //button to increase number of shares bought or sold
    private var minusButton = [UIButton]()          //button to decrease number of shares bought or sold
    
    private let initialCashLabel = UILabel()
    private let cashLeftLabel = UILabel()
    private var errorMessageLabel = UILabel()       //label to tell user when invalid transaction tried
    
    private var mainStack = [UIStackView]()         //main stack to display trading sheet
    private var subStack = [UIStackView]()          //sub stacks that will be added to main stack
    
    private var headLabel = UILabel()
    private var backButton = UIBarButtonItem()
    
    //configure label for cells in trading sheet
    func configureCellLabel(_ label: UILabel, _ textString: String, _ width: Int)
    {
        label.textColor = .white
        label.numberOfLines = 2
        label.text = textString
        label.frame = CGRect(x: 0, y: 0, width: width, height: 70)
        label.textAlignment = .center
    }
    
    public override func viewDidLoad() {
        
        //initialised for every round
        buy = [0,0,0,0]
        sell = [0,0,0,0]
        cashFlow  = [0,0,0,0]
        
        headLabel = customHeadLabel("Trading (Round \(round))")
        
        initialCashLabel.textColor = UIColor.init(white: 1, alpha: 0.9)
        initialCashLabel.font = UIFont.systemFont(ofSize: 20)
        initialCashLabel.text = "Initial Money: " + String(initialCash)
        initialCashLabel.frame = CGRect(x: 20, y: 125, width: w-20, height: 50)
        initialCashLabel.textAlignment = .left
        
        cashLeftLabel.textColor = UIColor.init(white: 1, alpha: 0.9)
        cashLeftLabel.font = UIFont.systemFont(ofSize: 20)
        cashLeftLabel.text = "Money Left:\t" + String(cashLeft)
        cashLeftLabel.frame = CGRect(x: 0, y: 575, width: w-20, height: 50)
        cashLeftLabel.textAlignment = .right
        
        errorMessageLabel.textColor = UIColor.init(white: 0.95, alpha: 1)
        errorMessageLabel.text = ""
        errorMessageLabel.frame = CGRect(x: 0, y: 630, width: w, height: 50)
        errorMessageLabel.textAlignment = .center
        
        //column titles of trading sheet
        let tableTitles = ["Stock", "Share Price($)", "Shares Held", "BUY", "SELL", "Cash Flow"]
        var txt: String!
        
        //cells for trading sheet
        var tableCell = [UIView]()
        
        //configuring main stack, [0] and [1] -> different widths
        for i in 0...1
        {
            mainStack.append(UIStackView())
            mainStack.last?.axis = .horizontal
            mainStack.last?.distribution = .fillEqually
            mainStack.last?.frame = CGRect(x: i*240, y: 200, width: 120*(i+2), height: 350)
        }
        
        let view = UIView()
        view.backgroundColor = UIColor.darkText
        
        //Development of complete trading sheet
        for i in 0...5
        {
            //configuring sub stack
            subStack.append(UIStackView())
            subStack.last?.axis = .vertical
            subStack.last?.distribution = .fillEqually
            subStack.last?.frame.size = CGSize(width: 80+(40*(i/3)), height: 350)
            
            //configuring table cell
            tableCell.append(UIView())
            tableCell.last?.frame.size = CGSize(width: 80+(40*(i/3)), height: 70)
            tableCell.last?.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
            
            //UI highlight for buy and sell column
            if(i==3 || i==4)
            {
                tableCell.last?.backgroundColor = UIColor.init(white: 1, alpha: CGFloat(0.8-Double(i)/10))
            }
            
            //configure cell label for column title
            tableCellLabel.append(UILabel())
            configureCellLabel(tableCellLabel.last!, tableTitles[i], 80+(40*(i/3)))
            
            //adding content to column title cells
            tableCell.last?.addSubview(tableCellLabel.last!)
            subStack.last?.addArrangedSubview(tableCell.last!)
            
            //Development of rows of respective column
            for j in 0...3
            {
                //configure table cell in accordance to mainstack width
                tableCell.append(UIView())
                tableCell.last?.frame.size = CGSize(width: 80+(40*(i/3)), height: 70)
                tableCell.last?.backgroundColor = UIColor.init(white: 1, alpha: 0.1)
                
                //configuring cell label
                tableCellLabel.append(UILabel())
                switch(i) {
                case 0:
                    txt = stockNames[j]
                case 1:
                    txt = String(sharePrices[j])
                case 2:
                    txt = String(currentNumberOfShares[j])
                case 3:
                    txt = String(buy[j])
                case 4:
                    txt = String(sell[j])
                case 5:
                    txt = String(cashFlow[j])
                default: return
                }
                configureCellLabel(tableCellLabel.last!, txt, 80+(40*(i/3)))
                if(i==1) {
                    tableCellLabel.last?.textColor = stockFlow[j]
                }
                
                //adding plus and minus buttons for buy and sell columns
                if(i==3 || i==4)
                {
                    plusButton.append(UIButton())
                    minusButton.append(UIButton())
                    plusButton.last?.setTitle("+", for: .normal)
                    minusButton.last?.setTitle("-", for: .normal)
                    
                    //tags given from 0-7
                    plusButton.last?.tag = j+((i/4)*i)
                    minusButton.last?.tag = j+((i/4)*i)
                    
                    plusButton.last?.sizeToFit()
                    minusButton.last?.sizeToFit()
                    plusButton.last?.center = CGPoint(x: 120-20, y: 35)
                    minusButton.last?.center = CGPoint(x: 15, y: 35)
                    plusButton.last?.addTarget(self, action: #selector(plus), for: .touchUpInside)
                    minusButton.last?.addTarget(self, action: #selector(minus), for: .touchUpInside)
                    
                    tableCell.last?.backgroundColor = UIColor.init(white: 1, alpha: CGFloat(0.8-Double(i)/10-0.1))
                    
                    tableCell.last?.addSubview(plusButton.last!)
                    tableCell.last?.addSubview(minusButton.last!)
                }
                
                //substack built for column i
                tableCell.last?.addSubview(tableCellLabel.last!)
                subStack.last?.addArrangedSubview(tableCell.last!)
                
            }
            //substack added to respective mainstack
            mainStack[i/3].addArrangedSubview(subStack.last!)
        }
        
        //bottom toolbar and buttons configured and added.
        backButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.rewind, target: self, action: #selector(prevVC))
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 30
        let nextButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fastForward, target: self, action: #selector(nextVC))
        let toolbar = customBottomToolbar()
        toolbar.setItems([backButton, space, nextButton], animated: false)
        
        //rendering
        view.addSubview(headLabel)
        view.addSubview(initialCashLabel)
        view.addSubview(cashLeftLabel)
        view.addSubview(errorMessageLabel)
        view.addSubview(mainStack[0])
        view.addSubview(mainStack[1])
        view.addSubview(toolbar)
        self.view = view
    }
    
    //present error message if invalid transaction made along with animation
    func presentErrorMessage() {
        //show
        self.errorMessageLabel.alpha = 1
        //hide with fade effect
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.5, delay: 1, options: .curveEaseIn, animations: {
            self.errorMessageLabel.alpha = 0
        })
    }
    
    //action for plus button in buy and sell column
    @objc func plus(_ sender: UIButton)
    {
        //button recognised through tag
        var i = sender.tag
        //index for tablecell and trablecelllabel calculated
        i = (i/4)+16+i
        
        var flow = 0        //temp cash flow variable
        
        //buy column
        if(sender.tag<=3) {
            //if shares of respective stock not sold in this round (AND) sufficient money present
            if(cashLeft>=(100*sharePrices[sender.tag]) && sell[sender.tag]==0) {
                buy[sender.tag] += 100
                tableCellLabel[i].text = String(buy[sender.tag])
                
                flow = -1 * buy[sender.tag] * sharePrices[sender.tag]
                cashFlow[sender.tag] = flow
                tableCellLabel[sender.tag + 26].text = String(cashFlow[sender.tag])
                
                cashLeft -= 100*sharePrices[sender.tag]
            }
            //show error message
            else {
                if (cashLeft < (100*sharePrices[sender.tag])) {
                    self.errorMessageLabel.text = "Money left is insufficient"
                } else {
                    self.errorMessageLabel.text = "Shares of the stock can either be bought or sold"
                }
                presentErrorMessage()
            }
        }
            
        //sell column
        else {
            //if shares of respective stock not bought (AND) sufficient shares held
            if(sell[(sender.tag)%4]<currentNumberOfShares[(sender.tag)%4] && buy[(sender.tag)%4]==0) {
                sell[(sender.tag)%4] += 100
                tableCellLabel[i].text = String(sell[(sender.tag)%4])
                
                flow = sell[(sender.tag)%4] * sharePrices[(sender.tag)%4]
                cashFlow[(sender.tag)%4] = flow
                tableCellLabel[(sender.tag % 4) + 26].text = String(cashFlow[(sender.tag)%4])
                
                cashLeft += 100*sharePrices[(sender.tag)%4]
            }
            //show error message
            else {
                if (buy[(sender.tag)%4] != 0) {
                    self.errorMessageLabel.text = "Shares of the stock can either be bought or sold"
                } else {
                    if currentNumberOfShares[(sender.tag)%4] == 0 {
                        self.errorMessageLabel.text = "Shares of this stock are unavailable. Short selling is not allowed."
                    } else {
                        self.errorMessageLabel.text = "No more shares are available to sell"
                    }
                }
                presentErrorMessage()
            }
        }
        cashLeftLabel.text = "Money Left:\t" + String(cashLeft)     //update cashleft label
    }
    
    @objc func minus(_ sender: UIButton)
    {
        var i = sender.tag
        i = (i/4)+16+i
        var flow = 0
        
        //buy column
        if(sender.tag<=3) {
            //if buy>0 i.e. minus allowed
            if(buy[sender.tag]>0) {
                buy[sender.tag] -= 100
                tableCellLabel[i].text = String(buy[sender.tag])
                
                flow = -1 * buy[sender.tag] * sharePrices[sender.tag]
                cashFlow[sender.tag] = flow
                tableCellLabel[sender.tag + 26].text = String(cashFlow[sender.tag])
                
                cashLeft += 100*sharePrices[sender.tag]
            }
            //show error message
            else {
                self.errorMessageLabel.text = "Shares for this stock haven't been bought in this round"
                presentErrorMessage()
            }
        }
        //sell column
        else {
            //if sell>0 (AND) sufficient money present
            if(sell[(sender.tag)%4]>0 && cashLeft>=(100*sharePrices[(sender.tag)%4])) {
                sell[(sender.tag)%4] -= 100
                tableCellLabel[i].text = String(sell[(sender.tag)%4])
                
                flow = sell[(sender.tag)%4] * sharePrices[(sender.tag)%4]
                cashFlow[(sender.tag)%4] = flow
                tableCellLabel[(sender.tag % 4) + 26].text = String(cashFlow[(sender.tag)%4])
                
                cashLeft -= 100*sharePrices[(sender.tag)%4]
            }
            //show error message
            else {
                if (sell[(sender.tag)%4] <= 0) {
                    self.errorMessageLabel.text = "Shares for this stock haven't been sold in this round"
                } else {
                    self.errorMessageLabel.text = "Insufficient money left to re-buy shares of this stock"
                }
                presentErrorMessage()
            }
        }
        cashLeftLabel.text = "Money Left:\t" + String(cashLeft)     //update cashleft label
    }
    
    @objc func prevVC() {
        dismiss(animated: false) {
        }
    }
    
    @objc func nextVC()
    {
        //if rounds over and final portfolio shown, goto final page.
        if(round == 4) {
            presentInFullScreen(FinalPageViewController(), animated: true)
        }
        
        let oldPrices = sharePrices
        
        //Update share prices
        switch (round) {
        case 1:
            sharePrices = [1600, 900, 1100, 1200]
        case 2:
            sharePrices = [1300, 1000, 950, 1300]
        case 3:
            sharePrices = [600, 1200, 1050, 800]
        default:
            return
        }
        
        //determine share flow, rise or fall.
        for x in 0...3
        {
            if(sharePrices[x] > oldPrices[x])
            {
                stockFlow[x] = UIColor.init(red: 0, green: 1, blue: 0.1, alpha: 0.9)
            }
            else if(sharePrices[x] < oldPrices[x])
            {
                stockFlow[x] = UIColor.init(red: 1, green: 0, blue: 0.1, alpha: 0.9)
            }
            else
            {
                stockFlow[x] = UIColor.lightText
            }
            currentNumberOfShares[x] = currentNumberOfShares[x] + buy[x] - sell[x]
        }
        
        initialCash = cashLeft
        
        round += 1      //next round
        if(round==4)    //if rounds over, show final portfolio
        {
            findPortfolio()
        }
        else            //show news and rumour for next round
        {
            presentInFullScreen(NewsAndRumoursViewController(), animated: true)
        }
    }
    
    //final portfolio
    func findPortfolio()
    {
        backButton.isEnabled = false
        
        headLabel.text = "Final Portfolio"
        tableCellLabel[5].text = "Final Prices"
        
        //animation, fade out mainstack[1] and initialcashlabel
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.mainStack[1].alpha = 0
            self.initialCashLabel.alpha = 0
        }) { (UIViewAnimatingPosition) in
            self.cashLeftLabel.textAlignment = .center
            self.cashLeftLabel.font = UIFont.systemFont(ofSize: 22)
            self.cashLeftLabel.text = "Final Portfolio Value:\t" + String(self.cashLeft)
        }
        
        //animation, repositon mainstack[0] and cashleftlabel
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.8, delay: 0.6, options: .curveEaseInOut, animations: {
            self.mainStack[0].frame.size.width = CGFloat(360)
            self.mainStack[0].center.x = CGFloat(w/2)
            self.mainStack[0].frame.origin.y -= CGFloat(50)
            
            self.cashLeftLabel.frame.origin.y -= CGFloat(20)
        })
        
        //update table cells
        for x in 0...3
        {
            tableCellLabel[x+6].text = String(sharePrices[x])
            tableCellLabel[x+6].textColor = stockFlow[x]
            tableCellLabel[x+11].text = String(currentNumberOfShares[x])
        }
        
        var i = 1.5
        
        //animation, Liquidation.
        for x in 0...3
        {
            let j = currentNumberOfShares[x]
            if(j==0) {
                continue
            }
            for y in 1...j
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + i) {
                    self.tableCellLabel[x+11].text = String(currentNumberOfShares[x]-y)
                    self.cashLeft = self.cashLeft + sharePrices[x]
                    self.cashLeftLabel.text = "Final Portfolio Value:\t" + String(self.cashLeft)
                }
                i += 0.1/Double(y)
            }
        }
        
        //Animation, Show net profit.
        DispatchQueue.main.asyncAfter(deadline: .now() + i + 0.1) {
            let profitLabel = UILabel()
            profitLabel.alpha = 0
            profitLabel.textColor = UIColor.white
            profitLabel.font = UIFont.systemFont(ofSize: 20)
            profitLabel.text = "Net Profit:\t" + String(self.cashLeft - 1000000)
            profitLabel.sizeToFit()
            profitLabel.center = CGPoint(x: w/2, y: Int(self.cashLeftLabel.frame.origin.y + 60))
            super.view.addSubview(profitLabel)
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                profitLabel.alpha = 0.9
            })
        }
    }
}
