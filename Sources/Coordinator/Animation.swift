//
//  Animation.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

public protocol AnimationPresentationDataSource: AnyObject {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
}

open class Animation: NSObject {

    public let presentAnimation: TransitionAnimator?
    public let dissmissAnimation: TransitionAnimator?

    public var isInteractive: Bool = false {
        didSet {
            self.presentAnimation?.isInteractive = isInteractive
            self.dissmissAnimation?.isInteractive = isInteractive
        }
    }

    public static var `default` = Animation(presentAnimation: nil, dissmissAnimation: nil)

    public init(presentAnimation: TransitionAnimator?, dissmissAnimation: TransitionAnimator?) {
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
        return isInteractive ?self.dissmissAnimation :nil

    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteractive ?self.dissmissAnimation :nil
    }

    open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }

}


private extension CGPoint {
    var vector: CGVector {
        return CGVector(dx: x, dy: y)
    }
}
