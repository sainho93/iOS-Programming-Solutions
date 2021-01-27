// 
//  Copyright © 2020 Big Nerd Ranch
//

import UIKit

class ConversionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For Silver Challenge: Adding a Gradient Layer
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.red.cgColor,
//                                UIColor.yellow.cgColor,
//                                UIColor.green.cgColor,
//                                UIColor.blue.cgColor]
//
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
    
        print("ConversionViewController loaded its view.")
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        let red_value = CGFloat.random(in: 0.0 ... 1.0)
        let green_value = CGFloat.random(in: 0.0 ... 1.0)
        let blue_value = CGFloat.random(in: 0.0 ... 1.0)
        let alpha_value = CGFloat.random(in: 0.0 ... 1.0)
        
        let color = UIColor(red: red_value, green: green_value, blue: blue_value, alpha: alpha_value)

        self.view.backgroundColor = color
    }
    
}

