//
//  BasicFlowController.swift
//  Youbeto
//
//  Created by MacBook Air on 22.06.2020.
//  Copyright © 2020 Denis Valshchikov. All rights reserved.
//

import UIKit

class BasicFlowController<T: HomeNavigationProtocol>: UICollectionViewController {

	weak var navigator: T?
}
