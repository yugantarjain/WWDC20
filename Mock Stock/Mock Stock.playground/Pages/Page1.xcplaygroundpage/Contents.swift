//  Created by Yugantar Jain.
//
//  "Mock Stock, for Planet Earth"
///  The playground features mock trading of shares of Earth, Mars, Moon, and Kepler 452-b exoplanet through a storyline based on the facts and projections of thousands of years to give an outlook of what the future holds for the world.
///
///  The project has been built upon many different disciplines including astrononmy, finance, environment, mathematics, and software development.
///
///  Experiencing this shall help in getting a basic understanding about stock trading, knowledge about a few astronomical facts, and of-course awareness about the environment.
//
//
//  Best viewed with Xcode in Dark Mode.
//  Thank you.


import PlaygroundSupport
import UIKit

let ViewController = IntroViewController()
ViewController.preferredContentSize = CGSize(width: 600, height: 750)

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = ViewController
