//
//  ViewController.swift
//
//  Created by patrick piemonte on 11/14/18.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015-present patrick piemonte (http://patrickpiemonte.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

class ViewController: UIViewController {

    // MARK: object lifecycle
    
    convenience init() {
        self.init(nibName: nil, bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // MARK: view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.autoresizingMask = ([.flexibleWidth, .flexibleHeight])
        self.view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        let button: BurstButton = BurstButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.center = self.view.center
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.setImage(UIImage(named: "unheart"), for: .selected)
      //  button.burstView.particleImage = UIImage(named: "burst") // for customization
        button.addTarget(self, action: #selector(ViewController.handleButton(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }

}

// MARK: - UIButton handler

extension ViewController {
    
    @objc func handleButton(_ button: BurstButton) {
        button.isSelected = !button.isSelected
    }
    
}

