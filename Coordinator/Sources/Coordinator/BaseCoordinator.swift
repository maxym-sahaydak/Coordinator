//
//  BaseCoordinator.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit

open class BaseCoordinator<StepType: Step, RooViewController: UIViewController>: Coordinator {
    public var viewConroller: UIViewController!


    //MARK: - Initialization

    public init(rootViewController: RooViewController) {
        self.rootViewController = rootViewController
    }

    public init(rootViewController: RooViewController, step: StepType) {
        self.rootViewController = rootViewController
        performTransitionAfterWindowAppeared(transition(for: step))
    }


    //MARK: - Public

    public private(set) var rootViewController: RooViewController

    public func navigate(to step: StepType) {
        fatalError("should be implemented in subclass")
    }

    open func transition(for step: StepType) -> Transition<RooViewController> {
        fatalError("should be implemented in subclass")
    }

    //MARK: - Open

    open var viewController: UIViewController! {
        rootViewController
    }

    //MARK: - Private

    private func performTransitionAfterWindowAppeared(_ transition: Transition<RooViewController>) {
        guard !UIApplication.shared.windows.contains(where: { $0.isKeyWindow }) else {
//            return performTransition(transition, with: TransitionOptions(animated: false))
//            return navigate(to: ste)
            return transition.perform(on: rootViewController, animated: true)
        }

        var windowAppearanceObserver: Any?

        windowAppearanceObserver = NotificationCenter.default.addObserver(
            forName: UIWindow.didBecomeKeyNotification, object: nil, queue: .main) { [weak self] _ in
            windowAppearanceObserver.map(NotificationCenter.default.removeObserver)
            windowAppearanceObserver = nil
            DispatchQueue.main.async {
                transition.perform(on: self?.rootViewController ?? .init(), animated: true)
//                self?.performTransition(transition, with: TransitionOptions(animated: false))
            }
        }
    }

}
