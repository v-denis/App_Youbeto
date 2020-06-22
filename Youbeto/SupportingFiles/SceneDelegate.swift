//
//  SceneDelegate.swift
//  YouTube
//
//  Created by MacBook Air on 21.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let myScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(frame: myScene.coordinateSpace.bounds)
		window?.windowScene = myScene
		let flowLayout = UICollectionViewFlowLayout()
		let homeVC = HomeController(collectionViewLayout: flowLayout)
		let navigationController = CustomNavigationViewController(rootViewController: homeVC)
		
		navigationController.navigationBar.tintColor = .white
		navigationController.navigationBar.shadowImage = UIImage()
		navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController.navigationBar.setBackgroundImage(UIImage(), for: .compact)
		navigationController.navigationBar.setBackgroundImage(UIImage(), for: .compactPrompt)
		navigationController.navigationBar.setBackgroundImage(UIImage(), for: .defaultPrompt)
		navigationController.navigationBar.isTranslucent = false
		navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.9019607843, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	
		guard let statusBarViewHeight = myScene.statusBarManager?.statusBarFrame.height, window != nil else { return }
		let statusBarBackgroundView = UIView()
		statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
		statusBarBackgroundView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
		window?.addSubview(statusBarBackgroundView)
		NSLayoutConstraint.activate([
			statusBarBackgroundView.topAnchor.constraint(equalTo: window!.topAnchor),
			statusBarBackgroundView.heightAnchor.constraint(equalToConstant: statusBarViewHeight),
			statusBarBackgroundView.leadingAnchor.constraint(equalTo: window!.leadingAnchor),
			statusBarBackgroundView.trailingAnchor.constraint(equalTo: window!.trailingAnchor)
		])
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}

	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}


}

