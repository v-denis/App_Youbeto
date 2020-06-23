//
//  ViewController.swift
//  YouTube
//
//  Created by MacBook Air on 21.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class HomeController: BasicFlowController<HomeNavigator> {
	
	override var prefersStatusBarHidden: Bool {
		return isStatusBarHidden
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	
	let redView = UIView()
	var isStatusBarHidden = false
	var titleViewLabel = UILabel()
	var currentScreen: ScreenName {
		switch menuBar.selectedIndexPath.item {
			case 0: return .home
			case 1: return .trending
			case 2: return .subscriptions
			case 3: return .account
			default: return .home
		}
	}
	let homeCellId = "HomeCellId"
	let trendindCellId = "trendindCellId"
	let subscriptionCellId = "subscriptionCellId"
	lazy var menuBar: MenuBar = {
		let mb = MenuBar()
		mb.translatesAutoresizingMaskIntoConstraints = false
		mb.homeController = self
		return mb
	}()
	lazy var settingsLauncher: SettingsLauncher = {
		let launcher = SettingsLauncher()
		launcher.homeController = self
		return launcher
	}()
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
//		setNeedsStatusBarAppearanceUpdate()
		setupCollectionView()
		setupMenuBar()
		setupBarButtonItems()
	}
	
	
	
	private func setupCollectionView() {
		
		if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
			layout.scrollDirection = .horizontal
			layout.minimumLineSpacing = 0
//			layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
			layout.estimatedItemSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.frame.height - 50)
		}
		
		collectionView.backgroundColor = .white
		collectionView.register(FeedCell.self, forCellWithReuseIdentifier: homeCellId)
		collectionView.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
		collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendindCellId)
		collectionView.isPagingEnabled = true
		collectionView.showsHorizontalScrollIndicator = false
//		collectionView.contentInsetAdjustmentBehavior = .automatic	//kills error in log consol about size of cells in collection view
		collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
		collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
	}
	
	
	private func setupMenuBar() {
		
		titleViewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 35, height: 30))
		titleViewLabel.text = " Home"
		titleViewLabel.textColor = .white
		titleViewLabel.font = UIFont.systemFont(ofSize: 20)
		navigationItem.titleView = titleViewLabel
		navigationController?.hidesBarsOnSwipe = true
		
		redView.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
		redView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(redView)
		view.addSubview(menuBar)
		
		NSLayoutConstraint.activate([
			redView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			redView.widthAnchor.constraint(equalTo: view.widthAnchor),
			redView.topAnchor.constraint(equalTo: view.topAnchor),
			redView.bottomAnchor.constraint(equalTo: menuBar.bottomAnchor),
			
			menuBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			menuBar.widthAnchor.constraint(equalTo: view.widthAnchor),
			menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			menuBar.heightAnchor.constraint(equalToConstant: 50)
		])
		
	}
	
	private func setupBarButtonItems() {
		let searchImage = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
		let searchBarButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchHandle))
		let dotsImage = UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
		let moreBarButton = UIBarButtonItem(image: dotsImage, style: .plain, target: self, action: #selector(moreHandle))
		searchBarButton.tintColor = .white
		moreBarButton.tintColor = .white
		navigationItem.rightBarButtonItems = [moreBarButton, searchBarButton]
	}
	
	
	@objc func searchHandle() {
		print("1")
	}
	
	@objc func moreHandle() {
		settingsLauncher.showSettings()
	}
	
	private func reloadCurrentScreenTitle() {
		titleViewLabel.text = currentScreen.rawValue
	}
	
	internal func showController(for setting: Setting) {
		let dummySettingVC = UIViewController()
		dummySettingVC.navigationItem.title = setting.name.rawValue
		dummySettingVC.view.backgroundColor = .white
		navigationController?.pushViewController(dummySettingVC, animated: true)
	}
		
	internal func scrollCollectionView(toItem item: Int)
	{
		collectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .centeredHorizontally, animated: true)
		reloadCurrentScreenTitle()
	}
	
		
}

//MARK: collection view methods
extension HomeController: UICollectionViewDelegateFlowLayout {
	
	
	override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
	{
		let selectedItem = targetContentOffset.pointee.x / view.frame.width
		menuBar.selectedIndexPath = IndexPath(item: Int(selectedItem), section: 0)
		reloadCurrentScreenTitle()
	}
	
	override func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
		menuBar.horizontalBarLeadingConstraint?.constant = scrollView.contentOffset.x / 4
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return 4
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		var cellIdentifier: String
		if indexPath.item == 0 {
			cellIdentifier = homeCellId
		} else if indexPath.item == 1 {
			cellIdentifier = trendindCellId
		} else {
			cellIdentifier = subscriptionCellId
		}
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
		if cell is FeedCell {
			(cell as! FeedCell).delegate = self
			(cell as! FeedCell).openVideoDelegate = self
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.frame.height - 50)
	}
	
	


}

extension HomeController: VideoCellDidTappedProtocol {
	
	func videoCellDidTapped(onVideo video: Video) {
		let presentVC = VideoPlayerViewController()
		presentVC.modalPresentationStyle = .fullScreen
		self.present(presentVC, animated: false, completion: nil)
	}
	
}



extension HomeController: ChangeStatusBarProtocol {
	
	func hideStatusBar() {
		isStatusBarHidden = true
	}

	func showStatusBar() {
		isStatusBarHidden = false
	}
	
}
