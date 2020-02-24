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

    public private(set) var propertyAnimator: UIViewPropertyAnimator?
    var isInteractive: Bool = false

    private var animatorForCurrentTransition: UIViewImplicitlyAnimating?

    public init(duration: TimeInterval, animation: @escaping (UIViewControllerContextTransitioning) -> UIViewPropertyAnimator) {
        self.animatioDuration = duration
        self.animation = animation
    }

    public func end() {
        animatorForCurrentTransition = nil
    }

    public override func finish() {
        animatorForCurrentTransition = nil
        super.finish()
    }

    public override func cancel() {
        animatorForCurrentTransition = nil
        super.cancel()
    }

    // MARK: - UIViewControllerAnimatedTransitioning

    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if let animatorForCurrentTransition = animatorForCurrentTransition {
            return animatorForCurrentTransition
        }
        self.animatorForCurrentTransition = animation(transitionContext)
        return self.animatorForCurrentTransition ?? animation(transitionContext)
    }

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animatioDuration
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        interruptibleAnimator(using: transitionContext).startAnimation()
    }

    public func animationEnded(_ transitionCompleted: Bool) {
        if transitionCompleted {
            animatorForCurrentTransition = nil
        }
    }
    
    open override func update(_ percentComplete: CGFloat) {
        print("percentComplete:  \(percentComplete)")
        super.update(percentComplete)
    }
    
}


