//
//  VideoLauncher.swift
//  YouTube
//
//  Created by MacBook Air on 27.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
	
	var timerForButtonHide: Timer?
	var isPlaying = false
	var player = AVPlayer()
	let activityIndicatorView: UIActivityIndicatorView = {
		let aiv = UIActivityIndicatorView(style: .large)
		aiv.color = .white
		aiv.translatesAutoresizingMaskIntoConstraints = false
		aiv.startAnimating()
		return aiv
	}()
	let pausePlayButton: UIButton = {
		let button = UIButton(type: .system)
		let image = UIImage(systemName: "pause.fill")
		button.translatesAutoresizingMaskIntoConstraints = false
		button.tintColor = UIColor.white.withAlphaComponent(0.9)
		button.isHidden = true
		button.setBackgroundImage(image, for: .normal)
		return button
	}()
	let controlsContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(white: 0, alpha: 0.5)
		return view
	}()
	let videoLengthLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .right
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: .subheadline)
		label.textColor = .white
		label.text = "00:00"
		return label
	}()
	let currentTimeLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.preferredFont(forTextStyle: .subheadline)
		label.textColor = .white
		label.text = "00:00"
		return label
	}()
	let videoTimerSlider: UISlider = {
		let slider = UISlider()
		let image = UIImage(systemName: "circle.fill")
		slider.translatesAutoresizingMaskIntoConstraints = false
		slider.minimumTrackTintColor = .red
		slider.maximumTrackTintColor = .white
		slider.tintColor = .red
		slider.setThumbImage(image, for: .highlighted)
		slider.setThumbImage(image, for: .selected)
		slider.setThumbImage(image, for: .normal)
		return slider
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
		startPlayingVideo()
		controlsContainerView.frame = frame
		addSubview(controlsContainerView)
		controlsContainerView.addSubview(activityIndicatorView)
		controlsContainerView.addSubview(pausePlayButton)
		controlsContainerView.addSubview(videoLengthLabel)
		controlsContainerView.addSubview(videoTimerSlider)
		controlsContainerView.addSubview(currentTimeLabel)
		controlsContainerView.addGestureRecognizer(tapGesture)
		
		NSLayoutConstraint.activate([
			activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
			activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
			pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor),
			pausePlayButton.widthAnchor.constraint(equalToConstant: 50),
			pausePlayButton.heightAnchor.constraint(equalTo: pausePlayButton.widthAnchor)
		])
		
		NSLayoutConstraint.activate([
			videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
			videoLengthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
			videoLengthLabel.widthAnchor.constraint(equalToConstant: 50),
			videoLengthLabel.heightAnchor.constraint(equalToConstant: 24)
		])
		
		NSLayoutConstraint.activate([
			videoTimerSlider.centerYAnchor.constraint(equalTo: videoLengthLabel.centerYAnchor),
			videoTimerSlider.heightAnchor.constraint(equalToConstant: 24),
			videoTimerSlider.trailingAnchor.constraint(equalTo: videoLengthLabel.leadingAnchor),
			videoTimerSlider.leadingAnchor.constraint(equalTo: currentTimeLabel.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			currentTimeLabel.centerYAnchor.constraint(equalTo: videoTimerSlider.centerYAnchor),
			currentTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
			currentTimeLabel.heightAnchor.constraint(equalToConstant: 24),
			currentTimeLabel.widthAnchor.constraint(equalToConstant: 50)
		])
		
		pausePlayButton.addTarget(self, action: #selector(pausePlayButtonHandle), for: .touchUpInside)
		videoTimerSlider.addTarget(self, action: #selector(timeSliderHandler), for: .valueChanged)
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
	{
		if keyPath == "currentItem.loadedTimeRanges" {
			activityIndicatorView.stopAnimating()
			controlsContainerView.backgroundColor = .clear
			pausePlayButton.isHidden = false
			isPlaying = true
			setupTimerToHidePlayPauseButton(withInterval: 3.0)
			
			if let currentItem = player.currentItem {
				videoLengthLabel.text = currentItem.duration.getStringOfSecondsAndMinutes()
				removeVideoLoadingObserver()
			}
			
		}
		
	}
	
	private func setupTimerToHidePlayPauseButton(withInterval interval: TimeInterval)
	{
		timerForButtonHide?.invalidate()
		timerForButtonHide = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: {[weak self] (timer) in
			guard let strongSelf = self else { return }
			strongSelf.pausePlayButton.alpha = 1.0
			UIView.animate(withDuration: 0.3, animations: {
				strongSelf.pausePlayButton.alpha = 0.0
			}) { (_) in
				strongSelf.pausePlayButton.isHidden = true
			}
		})
		RunLoop.current.add(timerForButtonHide!, forMode: .common)
	}
	
	private func startPlayingVideo() {
		let urlString = "https://pvv4.vkuservideo.net/c13032/e38Ozg8OzEzPg/videos/41c4b38d66.720.mp4"
		
		if let videoUrl = URL(string: urlString) {
			player = AVPlayer(url: videoUrl)
			player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
			
			let playerLayer = AVPlayerLayer(player: player)
			self.layer.addSublayer(playerLayer)
			playerLayer.frame = CGRect(x: 0, y: 44, width: frame.width, height: frame.height - 44)
//			playerLayer.frame = CGRect(x: 0, y: 44, width: frame.width, height: frame.height )
			
			player.play()
			
			//track player progress
			let checkingInterval = CMTime(value: 1, timescale: 4)
			player.addPeriodicTimeObserver(forInterval: checkingInterval, queue: DispatchQueue.main) { (time) in
				self.currentTimeLabel.text = time.getStringOfSecondsAndMinutes()
				
				if let duration = self.player.currentItem?.duration {
					let secondsDuration = CMTimeGetSeconds(duration)
					let currentSeconds = CMTimeGetSeconds(time)
					self.videoTimerSlider.value = Float(currentSeconds / secondsDuration)
				}

			}
		}
	}
	

	private func removeVideoLoadingObserver() {
		player.removeObserver(self, forKeyPath: "currentItem.loadedTimeRanges")
	}
	
	@objc private func timeSliderHandler(_ sender: UISlider)
	{
		if let videoDuration = player.currentItem?.duration {
			let totalSeconds = CMTimeGetSeconds(videoDuration)
			let slideredTime = Double(totalSeconds * Float64(videoTimerSlider.value))
			let seekTime = CMTime(seconds: slideredTime, preferredTimescale: videoDuration.timescale)
			player.pause()
			player.seek(to: seekTime)
			pausePlayButton.isHidden = false
			pausePlayButton.alpha = 1.0
			if isPlaying {
				player.play()
				setupTimerToHidePlayPauseButton(withInterval: 1.5)
			} else {
				setupTimerToHidePlayPauseButton(withInterval: 15)
			}
		}
		
	}
	
	@objc private func pausePlayButtonHandle(_ sender: UIButton)
	{
		if isPlaying {
			player.pause()
			pausePlayButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
			setupTimerToHidePlayPauseButton(withInterval: 15.0)
		} else {
			player.play()
			pausePlayButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
			setupTimerToHidePlayPauseButton(withInterval: 1.5)
		}
		isPlaying.toggle()
		
	}
	
	@objc private func handleTapGesture(_ sender: UITapGestureRecognizer)
	{
		if pausePlayButton.isHidden {
			pausePlayButton.alpha = 0.0
			pausePlayButton.isHidden = false
			UIView.animate(withDuration: 0.3, animations: {
				self.pausePlayButton.alpha = 1.0
			}) { (_) in
				self.setupTimerToHidePlayPauseButton(withInterval: 3.0)
			}
		} else {
			setupTimerToHidePlayPauseButton(withInterval: 0.0)
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	deinit {
		removeVideoLoadingObserver()
		timerForButtonHide?.invalidate()
	}
}




class VideoLauncher: NSObject {
	
	func showVideoPlayer()
	{
		if let keyWindow = Helper.keyWindow {
			let view = UIView(frame: CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10))
			let videoPlayerHeight = keyWindow.frame.width * 9 / 16 + 44
			let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoPlayerHeight))
			print(Helper.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)
			videoPlayerView.backgroundColor = .black
			view.backgroundColor = .white
			view.alpha = 0.0
			view.addSubview(videoPlayerView)
			keyWindow.addSubview(view)
			
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
				view.frame = keyWindow.frame
				view.alpha = 1.0
			}) { (completed) in
				keyWindow.rootViewController?.setNeedsStatusBarAppearanceUpdate()
			}
			
		}
		
	}
	
	
	
	
	
}
