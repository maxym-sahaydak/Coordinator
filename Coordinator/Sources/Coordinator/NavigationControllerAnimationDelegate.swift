//
//  NavigationControllerAnimationDelegate.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

open class NavigationControllerAnimationDelegate: NSObject {

    internal var delegate: UINavigationControllerDelegate?

    private var interactivePopGestureRecognizerDelegate: UIGestureRecognizerDelegate?
    private weak var navigationController: UINavigationController?

}

extension NavigationControllerAnimationDelegate: UINavigationControllerDelegate {


    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        //TODO: need to apply for coordinator transitions
        return delegate?.navigationController?(navigationController, interactionControllerFor: animationController)
    }

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //TODO: need to apply for coordinator transitions
        return delegate?.navigationController?(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //TODO: - add gesture if required ?

        delegate?.navigationController?(navigationController, didShow: viewController, animated: animated)
    }

    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        setupPopGestureRecognizer(navigationController: navigationController)
        delegate?.navigationController?(navigationController, willShow: viewController, animated: animated)
    }

}

extension NavigationControllerAnimationDelegate: UIGestureRecognizerDelegate {

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        //TODO: - update wiht ability to handle gestures and remove saved Presented (view controller)
        return navigationController?.viewControllers.count ?? 0 > 1
    }

    //MARK: - Open

    open func setupPopGestureRecognizer(navigationController: UINavigationController) {
        self.navigationController = navigationController
        guard let popGesture = navigationController.interactivePopGestureRecognizer,
            popGesture.delegate !== self else {
                return
        }
        interactivePopGestureRecognizerDelegate = popGesture.delegate
        popGesture.delegate = self
    }
}
