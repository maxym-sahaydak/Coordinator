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

    let presentAnimation: TransitionAnimator?
    let dissmissAnimation: TransitionAnimator?

    var isInteractive: Bool = false {
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

    func updateInteractiveTransition(_ percentComplete: CGFloat) {
//        let pa = interactiveAnimator

//        pa.fractionComplete = percentComplete
//        transitionContext?.updateInteractiveTransition(percentComplete)
//        dissmissAnimation?.
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
        return self.presentAnimation//?.interatctionController

    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.dissmissAnimation//?.interatctionController
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(animator: self, presentedViewController: presented, presentingViewController: presenting)//(presentedViewController: presented, presenting: presenting)
    }

}

public class PresentationController: UIPresentationController {

    public init(animator: Animation?, presentedViewController: UIViewController, presentingViewController: UIViewController?) {
        self.animator = animator
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    weak var animator: Animation?

    private var panGR: UIPanGestureRecognizer?
    private var hasStartedPan = false

    public override func presentationTransitionWillBegin() {
        setupView()
//        fadeinHandle()
        setupPanToDismiss()
        handleView.alpha = 0.0
        let transitionCoordinator = presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.handleView.alpha = 1.0
        }, completion: nil)
        super.presentationTransitionWillBegin()


    }

    public override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
    }

    public override func dismissalTransitionWillBegin() {
        let transitionCoordinator = presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.handleView.alpha = 0.0
        }, completion: nil)
        super.dismissalTransitionWillBegin()
    }

    public override func dismissalTransitionDidEnd(_ completed: Bool) {
//        fadeoutHandle()
        if completed {
            handleView.removeFromSuperview()
        }

        super.dismissalTransitionDidEnd(completed)
    }


    private func setupView() {
        guard let containerView = containerView else {
            return
        }
        containerView.addSubview(handleView)
        handleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            handleView.topAnchor.constraint(equalTo: containerView.topAnchor),
            handleView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            handleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            handleView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }

    private func setupPanToDismiss() {

        let gr = UIPanGestureRecognizer(target: self, action: #selector(panned))
        gr.delegate = self

        containerView?.addGestureRecognizer(gr)
        panGR = gr
    }

    @objc private func panned(_ gr: UIPanGestureRecognizer) {
        guard let containerView = containerView else { return }

        let verticalMove = gr.translation(in: containerView).y
        let pct = verticalMove / containerView.bounds.height
        let verticalVelocity = gr.velocity(in: containerView)

        switch gr.state {
        case .began:
            //    do not start dismiss until pan goes down
            if verticalMove <= 0 { return }
            //    setup flag that pan has finally started in the correct direction
            hasStartedPan = true
            //    and reset the movement so far
            gr.setTranslation(.zero, in: containerView)

            //    tell Animator that this will be interactive
//            cardAnimator.isInteractive = true
            animator?.isInteractive = true
//            animator?.dissmissAnimation?.interatctionController?.update(pct)

            //    and then initiate dismissal
            presentedViewController.dismiss(animated: true)


        case .changed:
            if !hasStartedPan { return }

//            animator.update
//            cardAnimator.updateInteractiveTransition(pct)
//            animator?.updateInteractiveTransition(pct)
//            animator?.dissmissAnimation?.interatctionController?.update(pct)
            animator?.dissmissAnimation?.update(pct)
            handleView.alpha = max(0, 1 - pct * 4)    //    handle disappears 4x faster


        case .ended, .cancelled:
            if !hasStartedPan { return }
            let vector = verticalVelocity.vector

            if verticalVelocity.y < 0 {
//                cardAnimator.cancelInteractiveTransition(with: vector)
                animator?.dissmissAnimation?.cancel()
                handleView.alpha = 1

            } else if verticalVelocity.y > 0 {
//                cardAnimator.finishInteractiveTransition(with: vector)
                animator?.dissmissAnimation?.finish()
                handleView.alpha = 0

            } else {
                if pct < 0.5 {
//                    cardAnimator.cancelInteractiveTransition(with: vector)
                    animator?.dissmissAnimation?.cancel()
                    handleView.alpha = 1
                } else {
//                    cardAnimator.finishInteractiveTransition(with: vector)
                    animator?.dissmissAnimation?.finish()
                    handleView.alpha = 0
                }
            }
            hasStartedPan = false

        default:
            break
        }
    }

//    func cancelInteractiveTransition(with velocity: CGVector = .zero) {
//        guard isInteractive else {
//            return
//        }
//
//        transitionContext?.cancelInteractiveTransition()
//
//        interactiveAnimator.isReversed = true    //    animate back to starting position
//
//        let pct = interactiveAnimator.fractionComplete
//        endInteraction(from: pct,
//                       withVelocity: velocity,
//                       durationFactor: 1 - pct)
//    }
//
//    func finishInteractiveTransition(with velocity: CGVector = .zero) {
//        guard isInteractive else {
//            return
//        }
//
//        transitionContext?.finishInteractiveTransition()
//
//        let pct = interactiveAnimator.fractionComplete
//        endInteraction(from: pct,
//                       withVelocity: velocity,
//                       durationFactor: pct)
//    }
//
//    func endInteraction(from percentComplete: CGFloat, withVelocity velocity: CGVector, durationFactor: CGFloat) {
//        switch interactiveAnimator.state {
//        case .inactive:
//            interactiveAnimator.startAnimation()
//        default:    //    case .active, .stopped, @unknown-futures
//            interactiveAnimator.continueAnimation(withTimingParameters: nil, durationFactor: durationFactor)
//        }
//    }

    private lazy var handleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        view.layer.cornerRadius = 3
        view.alpha = 0
        return view
    }()

    func fadeinHandle() {
        UIView.animate(withDuration: 0.15) {
            [weak self] in
            guard let self = self else { return }
            self.handleView.alpha = 1
        }
    }

    func fadeoutHandle() {
        UIView.animate(withDuration: 0.15) {
            [weak self] in
            guard let self = self else { return }
            self.handleView.alpha = 0
        }
    }

}

extension PresentationController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        if gestureRecognizer != panGR { return true }

        let otherView = otherGestureRecognizer.view

        //    allow unconditional panning if that other view is not `UIScrollView`
        guard let scrollView = otherView as? UIScrollView else {
            return true
        }

        //    if it is `UIScrollView`,
        //    allow panning only if its content is at the very top
        if (scrollView.contentOffset.y + scrollView.contentInset.top) == 0 {
            return true
        }

        //    otherwise, disallow pan to dismiss
        return false
    }
}

private extension CGPoint {
    var vector: CGVector {
        return CGVector(dx: x, dy: y)
    }
}
