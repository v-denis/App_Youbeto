//
//  CustomNavigationViewController.swift
//  YouTube
//
//  Created by MacBook Air on 27.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

	override var prefersStatusBarHidden: Bool {
		return false
	}
	
	override var childForStatusBarHidden: UIViewController? {
		return self.visibleViewController ?? nil
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	
	
	
	
}
