//
//  VideoPlayerViewController.swift
//  YouTube
//
//  Created by MacBook Air on 14.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class VideoPlayerViewController: UIViewController {

	let videoPlayerHeight = Helper.keyWindow!.frame.width * 9 / 16 + 44
	lazy var videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: videoPlayerHeight))
	lazy var tableView = UITableView(frame: CGRect(x: 0, y: self.videoPlayerView.frame.maxY, width: view.frame.width, height: view.frame.height - self.videoPlayerView.frame.height), style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
		Helper.keyWindow?.backgroundColor = .white
		videoPlayerView.backgroundColor = .black
		view.addSubview(videoPlayerView)
		view.addSubview(tableView)
		view.backgroundColor = .white
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "videoBottomCell")
//		view.frame = CGRect.zero
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		view.frame = CGRect.zero
		
		if let keyWindowFrame = Helper.keyWindow?.frame {
			view.frame = CGRect(x: keyWindowFrame.width - 10, y: keyWindowFrame.height - 10, width: 10, height: 10)
		}
		
		guard let keyWindowFrame = Helper.keyWindow?.frame else { return }
		
		view.alpha = 0.0
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
			self.view.alpha = 1.0
			self.view.frame = CGRect(x: 0, y: 0, width: keyWindowFrame.width, height: keyWindowFrame.height)
		}) { (_) in
			
		}
	}
	
	

   
	

}


extension VideoPlayerViewController: UITableViewDelegate, UITableViewDataSource {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 30
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "videoBottomCell", for: indexPath)
		cell.textLabel?.text = "hello world"
		return cell
	}
	
}
