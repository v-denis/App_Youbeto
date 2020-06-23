//
//  VideoLauncher.swift
//  YouTube
//
//  Created by MacBook Air on 27.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit
import AVFoundation

class VideoLauncher: NSObject {

	let keyWindow = MainNavigator.shared.window
	var videoPlayerHeight: CGFloat {
		return keyWindow.frame.width * 9 / 16 + 44
	}
	var bottomViewHeight: CGFloat {
		return keyWindow.frame.height - videoPlayerHeight
	}
	var videoPlayerView: VideoPlayerView?
	var bottomView: VideoPlayerBottomView?
	var mainView: UIView?
	
	func showVideoPlayer(withLink link: String)
	{
		let mainViewFrame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
		mainView = UIView(frame: mainViewFrame)
		mainView?.backgroundColor = .white
		mainView?.alpha = 0.0
		configurateBottomView()
		configurateVideoPlayerView(for: link)
		mainView?.addSubview(bottomView ?? UIView())
		mainView?.addSubview(videoPlayerView ?? UIView())
		keyWindow.addSubview(mainView ?? UIView())
		
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
			self.mainView?.frame = self.keyWindow.frame
			self.mainView?.alpha = 1.0
		}) { (completed) in
			self.keyWindow.rootViewController?.setNeedsStatusBarAppearanceUpdate()
		}
		
	}
	
	private func configurateVideoPlayerView(for link: String) {
		let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoPlayerHeight)
		videoPlayerView = VideoPlayerView(frame: videoPlayerFrame, andLink: link)
		videoPlayerView?.delegate = self
		videoPlayerView?.backgroundColor = .black
	}
	
	private func configurateBottomView() {
		let bottomViewFrame = CGRect(x: 0, y: videoPlayerHeight, width: keyWindow.frame.width, height: bottomViewHeight)
		bottomView = VideoPlayerBottomView(frame: bottomViewFrame)
	}
	
	deinit {
		print("video launcher deinited")
	}
	
	
	
}

//MARK: - CloseVideoPlayerProtocol
extension VideoLauncher: CloseVideoPlayerProtocol {
	
	func closeVideoPlayer() {
		if mainView != nil {
			mainView?.subviews.forEach({ $0.removeFromSuperview() })
			mainView!.removeFromSuperview()
		}
		mainView = nil
		videoPlayerView = nil
	}
}
