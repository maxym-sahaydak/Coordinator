//
//  BaseCoordinator.swift
//  Coordinator
//
//  Created by Maxym Sahaydak on 03.02.2020.
//  Copyright © 2020 Solo Sciences, Inc. All rights reserved.
//

import Foundation
import UIKit


open class BaseCoordinator<StepType: Step, TransitionType: TransitionProtocol>: Coordinator {
    
    public typealias RootViewController = TransitionType.RootViewController

    public var viewConroller: UIViewController!

    //MARK: - Initialization

    public init(rootViewController: RootViewController) {
        self.rootViewController = rootViewController
    }

    public init(rootViewController: RootViewController, step: StepType) {
        self.rootViewController = rootViewController
        performTransitionAfterWindowAppeared(transition(for: step))
    }


    //MARK: - Public

    public private(set) var rootViewController: RootViewController

    public func navigate(to step: StepType) {
        fatalError("should be implemented in subclass")
    }

    open func transition(for step: StepType) -> Transition<RootViewController> {
        fatalError("should be implemented in subclass")
    }

    //MARK: - Open

    open var viewController: UIViewController! {
        rootViewController
    }

    //MARK: - Private

    private func performTransitionAfterWindowAppeared(_ transition: Transition<RootViewController>) {
        guard !UIApplication.shared.windows.contains(where: { $0.isKeyWindow }) else {
            return transition.perform(on: rootViewController, completion: nil)
        }

        var windowAppearanceObserver: Any?

        windowAppearanceObserver = NotificationCenter.default.addObserver(
            forName: UIWindow.didBecomeKeyNotification, object: nil, queue: .main) { [weak self] _ in
            windowAppearanceObserver.map(NotificationCenter.default.removeObserver)
            windowAppearanceObserver = nil
            DispatchQueue.main.async {
                transition.perform(on: self?.rootViewController ?? .init(), completion: nil)
            }
        }
    }

}
