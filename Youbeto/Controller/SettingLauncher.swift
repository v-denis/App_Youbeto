//
//  SettingLauncher.swift
//  YouTube
//
//  Created by MacBook Air on 25.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
	
	weak var homeController: HomeController?
	private let blackView = UIView()
	private let settingsCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .white
		return cv
	}()
	private let settingsCellId = "SettingsCell"
	private let staticCellHeight: CGFloat = 55
	
	private let settingsArray: [Setting] = {
		return [
			Setting(name: .settings, imageName: "gear"),
			Setting(name: .termsAndPrivacy, imageName: "lock.fill"),
			Setting(name: .sendFeedBack, imageName: "t.bubble.fill"),
			Setting(name: .help, imageName: "questionmark.circle.fill"),
			Setting(name: .switchAccount, imageName: "person.circle.fill"),
			Setting(name: .cancel, imageName: "multiply"),
		]
	}()
	
	override init() {
		super.init()
		
		settingsCollectionView.isScrollEnabled = false
		settingsCollectionView.delegate = self
		settingsCollectionView.dataSource = self
		settingsCollectionView.register(SettingsCell.self, forCellWithReuseIdentifier: settingsCellId)
	}
	
	public func showSettings() {
		
		if let window = Helper.keyWindow {
			
			let collectionViewHeight: CGFloat = CGFloat(settingsArray.count) * staticCellHeight + 16
			let collectionYPosition = window.frame.height - collectionViewHeight
			
			settingsCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: collectionViewHeight)
			blackView.frame = window.frame
			blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
			blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissBlackView)))
			
			window.addSubview(blackView)
			window.addSubview(settingsCollectionView)
			
			blackView.alpha = 0.0
			
			UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
				self.blackView.alpha = 1.0
				self.settingsCollectionView.frame.origin = CGPoint(x: 0, y: collectionYPosition)
			})
						
		}
		
		
	}
	
	private func hideSettingsMenu(forSetting setting: Setting? = nil) {
		
		if let window = Helper.keyWindow {
			UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
				self.blackView.alpha = 0.0
				self.settingsCollectionView.frame.origin = CGPoint(x: 0, y: window.frame.height)
			}) {[weak self] (_) in
				self?.blackView.removeFromSuperview()
				self?.settingsCollectionView.removeFromSuperview()
				if setting != nil {
					self?.homeController?.showController(for: setting!)
				}
			}
		}
		
	}
	
	@objc private func handleDismissBlackView(_ sender: UITapGestureRecognizer) {
		hideSettingsMenu()
	}
	
	deinit {
		print("Settings Launcher deinited!")
	}
	
}


//MARK: Collection view delegate and data source methods
extension SettingsLauncher: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return settingsArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: settingsCellId, for: indexPath) as! SettingsCell
		let currentItemSetting = settingsArray[indexPath.item]
		cell.setting = currentItemSetting
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: staticCellHeight)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let selectedSetting = settingsArray[indexPath.item]
		if selectedSetting.name == .cancel  {
			hideSettingsMenu()
		} else {
			hideSettingsMenu(forSetting: selectedSetting)
		}
		
	}
	
	
}
