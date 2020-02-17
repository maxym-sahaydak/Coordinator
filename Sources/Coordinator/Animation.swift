//
//  Animation.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

open class Animation: NSObject {

    let presentAnimation: UIViewControllerAnimatedTransitioning?
    let dissmissAnimation: UIViewControllerAnimatedTransitioning?

    public static var `default` = Animation(presentAnimation: nil, dissmissAnimation: nil)

    public init(presentAnimation: UIViewControllerAnimatedTransitioning?, dissmissAnimation: UIViewControllerAnimatedTransitioning?) {
        self.presentAnimation = presentAnimation
        self.dissmissAnimation = dissmissAnimation
    }

}


extension Animation: UIViewControllerTransitioningDelegate {

    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presentAnimation
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.dissmissAnimation
    }

    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        #warning("add interaction")
        return nil
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        #warning("add interaction")
        return nil
    }

}
