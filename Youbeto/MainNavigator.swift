//
//  MainNavigator.swift
//  Youbeto
//
//  Created by MacBook Air on 22.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

protocol BasicNavigationProtocol {
	func firstVCtoShow() -> UIViewController
}

protocol HomeNavigationProtocol: class {
	associatedtype Destination
	
	func show(destination: Destination)
}

class MainNavigator {
	
	static let shared = MainNavigator()
	private var navigators: [BasicNavigationProtocol]
	
	let window: UIWindow
	
	init() {
		window = UIWindow()
		
		let homeNavigator = HomeNavigator()
		let navRootVC = homeNavigator.firstVCtoShow()
		let navigationVC = CustomNavigationViewController(rootViewController: navRootVC)
		navigators = [homeNavigator]
		
		window.rootViewController = navigationVC
		window.makeKey()
	}
}
