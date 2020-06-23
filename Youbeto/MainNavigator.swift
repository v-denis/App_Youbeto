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
		
		navigationVC.navigationBar.tintColor = .white
		navigationVC.navigationBar.shadowImage = UIImage()
		navigationVC.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationVC.navigationBar.setBackgroundImage(UIImage(), for: .compact)
		navigationVC.navigationBar.setBackgroundImage(UIImage(), for: .compactPrompt)
		navigationVC.navigationBar.setBackgroundImage(UIImage(), for: .defaultPrompt)
		navigationVC.navigationBar.isTranslucent = false
		navigationVC.navigationBar.barTintColor = #colorLiteral(red: 0.9019607843, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
		
		window.rootViewController = navigationVC
		window.makeKeyAndVisible()
		
		
	}
	
	func configurateStatusBarView(with scene: UIWindowScene) {
		guard let statusBarViewHeight = scene.statusBarManager?.statusBarFrame.height else { return }
		let statusBarBackgroundView = UIView()
		statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
		statusBarBackgroundView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
		window.addSubview(statusBarBackgroundView)
		NSLayoutConstraint.activate([
			statusBarBackgroundView.topAnchor.constraint(equalTo: window.topAnchor),
			statusBarBackgroundView.heightAnchor.constraint(equalToConstant: statusBarViewHeight),
			statusBarBackgroundView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
			statusBarBackgroundView.trailingAnchor.constraint(equalTo: window.trailingAnchor)
		])
	}
	
}
