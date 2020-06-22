//
//  CustomBar.swift
//  YouTube
//
//  Created by MacBook Air on 22.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class MenuBar: UIView {
	
	private let imageNamesArray = ["house.fill","flame.fill","person.2.square.stack.fill","person.fill"]
	private let cellId = "MenuBarCell"
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		cv.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.1215686275, blue: 0.1215686275, alpha: 1)
		cv.translatesAutoresizingMaskIntoConstraints = false
		return cv
	}()

	weak var homeController: HomeController?
	internal var selectedIndexPath = IndexPath(item: 0, section: 0) {
		didSet {
			collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
		}
	}
	internal var horizontalBarLeadingConstraint: NSLayoutConstraint?
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		setupMenuBar()
		setupBottomHorizontalBar()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	private func setupMenuBar() {
		addSubview(collectionView)
		
		collectionView.delegate = self
		collectionView.dataSource = self
		NSLayoutConstraint.activate([
			collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
			collectionView.widthAnchor.constraint(equalTo: widthAnchor),
			collectionView.heightAnchor.constraint(equalTo: heightAnchor),
			collectionView.topAnchor.constraint(equalTo: topAnchor)
		])
		collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: cellId)
		
	}
	
	
	private func setupBottomHorizontalBar() {
		
		let horizontalBarView = UIView()
		horizontalBarView.backgroundColor = UIColor(white: 0.96, alpha: 1)
		horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(horizontalBarView)
		
		NSLayoutConstraint.activate([
			horizontalBarView.heightAnchor.constraint(equalToConstant: 4),
			horizontalBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
			horizontalBarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4)
		])
		
		horizontalBarLeadingConstraint = horizontalBarView.leadingAnchor.constraint(equalTo: leadingAnchor)
		horizontalBarLeadingConstraint?.isActive = true
	}
	
	
}


//MARK: collection view
extension MenuBar: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		selectedIndexPath = indexPath
		homeController?.scrollCollectionView(toItem: indexPath.item)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuBarCell
		cell.buttonImageView.image = UIImage(systemName: imageNamesArray[indexPath.item]) 
		cell.tintColor = #colorLiteral(red: 0.3568627451, green: 0.05490196078, blue: 0.05098039216, alpha: 1)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: bounds.width / 4, height: bounds.height)
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}

}


