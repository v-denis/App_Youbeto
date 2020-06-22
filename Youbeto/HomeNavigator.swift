//
//  HomeNavigator.swift
//  Youbeto
//
//  Created by MacBook Air on 22.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit


class HomeNavigator  {
	
	private let initialVC: UIViewController
	private var currentVC: UIViewController
	
	init() {
		let flowLayout = UICollectionViewFlowLayout()
		initialVC = HomeController(collectionViewLayout: flowLayout)
		currentVC = initialVC
		
		if let firstVC = initialVC as? BasicFlowController<HomeNavigator> {
			firstVC.navigator = self
		}
	}
	
	
}

extension HomeNavigator: HomeNavigationProtocol {
	
	enum Destination: String {
		case homeController
	}
	
	func show(destination: Destination) {
		if let destVC = getHomeController(by: destination) {
			destVC.navigator = self
			currentVC.present(destVC, animated: true) { [weak self] in
				guard let self = self else { return }
				self.currentVC = destVC
			}
		}
		
	}
	
	func getHomeController(by destination: Destination) -> BasicFlowController<HomeNavigator>? {
		switch destination {
			case .homeController:
				let flowLayout = UICollectionViewFlowLayout()
				return HomeController(collectionViewLayout: flowLayout)
		}
	}
	
	
}

extension HomeNavigator: BasicNavigationProtocol {
	
	func firstVCtoShow() -> UIViewController {
		return initialVC
	}
}
