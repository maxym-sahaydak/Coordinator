//
//  File.swift
//  
//
//  Created by Maxym Sahaydak on 17.02.2020.
//

import Foundation
import UIKit

extension UINavigationController {

    func push(_ viewController: UIViewController, options: TransitionOptions = .default, animation: Animation?, completion: NavigationHandler?) {

        if let animation = animation {
            viewController.transitioningDelegate = animation
        }

        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)

        autoreleasepool {
            pushViewController(viewController, animated: options.animated)
        }
        CATransaction.commit()

    }
}
