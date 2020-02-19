//
//  File.swift
//  
//
//  Created by Maxym Sahaydak on 17.02.2020.
//

import Foundation
import UIKit



open class TransitionAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {

    public private(set) var animatioDuration: TimeInterval
    private(set) var animation: (UIViewControllerContextTransitioning) -> UIViewPropertyAnimator
//    public var interatctionController: TransitionInteractiveControllerProtocol?

    public private(set) var propertyAnimator: UIViewPropertyAnimator?
    var isInteractive: Bool = false

    public init(duration: TimeInterval, animation: @escaping (UIViewControllerContextTransitioning) -> UIViewPropertyAnimator) {
        self.animatioDuration = duration
        self.animation = animation
//        self.interatctionController = TransitionInteractiveController(animation: animation)
    }

    open func start() {
        // TODO: - Implement later
//        interatctionController = ger
    }

    public func end() {
//        interatctionController = nil
    }

    // MARK: - UIViewControllerAnimatedTransitioning

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animatioDuration
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        animation(transitionContext).startAnimation()
    }
    
    open override func update(_ percentComplete: CGFloat) {
        print("percentComplete:  \(percentComplete)")
        super.update(percentComplete)
    }
    
}


