//
//  VideoPlayerView.swift
//  Youbeto
//
//  Created by MacBook Air on 22.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit
import AVFoundation

protocol CloseVideoPlayerProtocol: class {
	func closeVideoPlayer()
}


class VideoPlayerView: UIView {
	
	var delegate: CloseVideoPlayerProtocol?
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
	let closeVideoPlayerButton: UIButton = {
		let button = UIButton(type: .system)
		let image = UIImage(systemName: "chevron.compact.down")
		button.translatesAutoresizingMaskIntoConstraints = false
		button.tintColor = UIColor.white.withAlphaComponent(0.95)
		button.setBackgroundImage(image, for: .normal)
		return button
	}()
	let pausePlayButton: UIButton = {
		let button = UIButton(type: .system)
		let image = UIImage(systemName: "pause.fill")
		button.translatesAutoresizingMaskIntoConstraints = false
		button.tintColor = UIColor.white.withAlphaComponent(0.95)
		button.isHidden = true
		button.setBackgroundImage(image, for: .normal)
		return button
	}()
	let controlsContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
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
		slider.isEnabled = false
		return slider
	}()
	
	init(frame: CGRect, andLink link: String) {
		super.init(frame: frame)
		
		setupDarkLayer()
		addPlayerToSublayer(andCheck: link)
		controlElementsSetupLayout()
		configuratingTapGesture()
		closeVideoPlayerButton.addTarget(self, action: #selector(closeVideoPlayerButtonHandle), for: .touchUpInside)
		pausePlayButton.addTarget(self, action: #selector(pausePlayButtonHandle), for: .touchUpInside)
		videoTimerSlider.addTarget(self, action: #selector(timeSliderHandler), for: .valueChanged)
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
	}
	
	override func removeFromSuperview() {
		super.removeFromSuperview()
		delegate = nil
		player.pause()
		player.actionAtItemEnd = .pause
//		removeVideoLoadingObserver()	//removed earlier in func observeValue
		timerForButtonHide?.invalidate()
	}
	
	deinit {
		print("video player deinited!!")
	}
	
}

//MARK: - Main video player configurations
extension VideoPlayerView
{
	
	private func addPlayerToSublayer(andCheck urlString: String) {
		if let videoUrl = URL(string: urlString) {
			player = AVPlayer(url: videoUrl)
			let playerLayer = AVPlayerLayer(player: player)
			self.layer.addSublayer(playerLayer)
			var topShift: CGFloat = 0
			if Helper.hasTopNotch {
				topShift = MainNavigator.shared.window.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
			}
			playerLayer.frame = CGRect(x: 0, y: topShift, width: frame.width, height: frame.height - topShift)
			startPlayingVideo()
		} else {
			print("startPlayingVideo error: Incorrent link")
		}
	}
	
	private func startPlayingVideo() {
		player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
		player.play()
		//track player progress
		let checkingInterval = CMTime(value: 1, timescale: 4)
		player.addPeriodicTimeObserver(forInterval: checkingInterval, queue: DispatchQueue.main) {[weak self] (time) in
			self?.currentTimeLabel.text = time.getStringOfSecondsAndMinutes()
			if let duration = self?.player.currentItem?.duration {
				let secondsDuration = CMTimeGetSeconds(duration)
				let currentSeconds = CMTimeGetSeconds(time)
				self?.videoTimerSlider.value = Float(currentSeconds / secondsDuration)
			}
		}
	}
	
}

//MARK: - Observers
extension VideoPlayerView
{
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
	{
		if keyPath == "currentItem.loadedTimeRanges" {
			activityIndicatorView.stopAnimating()
			videoTimerSlider.isEnabled = true
//			controlsContainerView.isHidden = false
			pausePlayButton.isHidden = false
			isPlaying = true
			setupTimerToHidePlayPauseButton(withInterval: 3.0)
			
			if let currentItem = player.currentItem {
				videoLengthLabel.text = currentItem.duration.getStringOfSecondsAndMinutes()
				removeVideoLoadingObserver()
			}
		}
	}
	
	private func removeVideoLoadingObserver() {
		player.removeObserver(self, forKeyPath: "currentItem.loadedTimeRanges")
	}
}


//MARK: - Autolayout
extension VideoPlayerView {
	
	private func controlElementsSetupLayout() {
		controlsContainerView.frame = frame
		addSubview(controlsContainerView)
		Helper.addViewsTo(superView: controlsContainerView, views: [activityIndicatorView, pausePlayButton, videoLengthLabel, videoTimerSlider, currentTimeLabel, closeVideoPlayerButton])
		
		NSLayoutConstraint.activate([
			activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
			activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
			pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor),
			pausePlayButton.widthAnchor.constraint(equalToConstant: 50),
			pausePlayButton.heightAnchor.constraint(equalTo: pausePlayButton.widthAnchor)
		])
		
		NSLayoutConstraint.activate([
			closeVideoPlayerButton.heightAnchor.constraint(equalToConstant: 40),
			closeVideoPlayerButton.widthAnchor.constraint(equalTo: closeVideoPlayerButton.heightAnchor),
			closeVideoPlayerButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
			closeVideoPlayerButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
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
	}
	
	private func setupDarkLayer() {
		let darkLayer = CALayer()
		darkLayer.frame = bounds
		let darkColor = UIColor.black.withAlphaComponent(0.25)
		darkLayer.backgroundColor = darkColor.cgColor
		controlsContainerView.layer.addSublayer(darkLayer)
	}
	
}

//MARK: - gestures
extension VideoPlayerView {
	
	private func configuratingTapGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
		self.addGestureRecognizer(tapGesture)
	}
	
	@objc private func handleTapGesture(_ sender: UITapGestureRecognizer)
	{
		if controlsContainerView.isHidden {
			controlsContainerView.alpha = 0.0
			controlsContainerView.isHidden = false
			UIView.animate(withDuration: 0.3, animations: { [weak self] in
				self?.controlsContainerView.alpha = 1.0
			}) { (_) in
				self.setupTimerToHidePlayPauseButton(withInterval: 4.0)
			}
		} else {
			controlsContainerView.alpha = 0.0
			setupTimerToHidePlayPauseButton(withInterval: 0.0)
		}
	}
}


//MARK: - video player elements configration
extension VideoPlayerView
{
	private func setupTimerToHidePlayPauseButton(withInterval interval: TimeInterval)
	{
		timerForButtonHide?.invalidate()
		timerForButtonHide = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: {[weak self] (timer) in
			guard let strongSelf = self else { return }
			strongSelf.controlsContainerView.alpha = 1.0
			UIView.animate(withDuration: 0.3, animations: {
				strongSelf.controlsContainerView.alpha = 0.0
			}) { (_) in
				strongSelf.controlsContainerView.isHidden = true
			}
		})
		RunLoop.current.add(timerForButtonHide!, forMode: .common)
	}

	@objc private func timeSliderHandler(_ sender: UISlider)
	{
		if let videoDuration = player.currentItem?.duration {
			let totalSeconds = CMTimeGetSeconds(videoDuration)
			let slideredTime = Double(totalSeconds * Float64(videoTimerSlider.value))
			let seekTime = CMTime(seconds: slideredTime, preferredTimescale: videoDuration.timescale)
			player.pause()
			player.seek(to: seekTime)
			controlsContainerView.isHidden = false
			controlsContainerView.alpha = 1.0
			if isPlaying {
				player.play()
				setupTimerToHidePlayPauseButton(withInterval: 1.5)
			} else {
				setupTimerToHidePlayPauseButton(withInterval: 15)
			}
		}
		
	}
	
	@objc private func closeVideoPlayerButtonHandle(_ sender: UIButton) {
		delegate?.closeVideoPlayer()
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
			setupTimerToHidePlayPauseButton(withInterval: 3.0)
		}
		isPlaying.toggle()
		
	}
}
