//
//  ViewController.swift
//  Example
//
//  Created by tksu92 on 01/21/2021.
//  Copyright (c) 2021 tksu92. All rights reserved.
//

import UIKit
import TextFieldToken

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    var tokenView: TokenTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tokenView = TokenTextView()
        containerView.addSubview(tokenView)
        tokenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(150)
        }
//        tokenView.setText(text: UserDefaultLocal.shared.getDefaultName().mark)
    }

    @IBAction func selectAction(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

