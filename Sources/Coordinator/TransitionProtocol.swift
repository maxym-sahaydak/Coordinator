//
//  Transiotion.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

/// Base protocol to implement any transitions

public protocol TransitionProtocol {

/// Type of viewController which will execute transition
    associatedtype RootViewController: UIViewController


    func perform(on rootViewController: RootViewController, options: TransitionOptions, completion: NavigationHandler?)
}
