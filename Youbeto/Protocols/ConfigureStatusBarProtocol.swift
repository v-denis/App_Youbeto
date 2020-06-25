//
//  ChangeStatusBarProtocol.swift
//  YouTube
//
//  Created by MacBook Air on 27.05.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import Foundation


public protocol HideStatusBarProtocol: class {
	func hideStatusBar()
}

public protocol ShowStatusBarProtocol: class {
	func showStatusBar()
}

public typealias ConfigureStatusBarProtocol = ShowStatusBarProtocol & HideStatusBarProtocol
