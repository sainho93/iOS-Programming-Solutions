// 
//  Copyright © 2020 Big Nerd Ranch
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        // For Silver Challenge: Adding a Gradient Layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor,
                                UIColor.yellow.cgColor,
                                UIColor.green.cgColor,
                                UIColor.blue.cgColor]
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

