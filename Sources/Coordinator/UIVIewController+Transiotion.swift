//
//  File.swift
//  
//
//  Created by Maxym Sahaydak on 16.02.2020.
//

import Foundation
import UIKit

extension UIViewController {

    func show(_ viewController: UIViewController, options: TransitionOptions, completion: NavigationHandler?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)

        autoreleasepool {
            show(viewController, sender: nil)
        }
        CATransaction.commit()
    }

    func showDetail(_ viewController: UIViewController, options: TransitionOptions, completion: NavigationHandler?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)

        autoreleasepool {
            showDetailViewController(viewController, sender: nil)
        }

        CATransaction.commit()
    }

    func present(onRoot: Bool = false,
                 _ viewController: UIViewController,
                 animation: Animation? = nil,
                 options: TransitionOptions = .default,
                 completion: NavigationHandler?) {

        if let animation = animation {
            viewController.transitioningDelegate = animation
        }

        let presenter = onRoot ?self :topPresentedViewController

        presenter.present(viewController, animated: options.animated, completion: completion)
    }

    func dismiss(toRoot: Bool = false,
                 options: TransitionOptions = .default,
                 animation: Animation? = nil,
                 completion: NavigationHandler?) {

        let presentedViewController = topPresentedViewController

        if let animation = animation {
            presentedViewController.transitioningDelegate = animation
        }

        let dismissal = toRoot ?self :presentedViewController
        dismissal.dismiss(animated: options.animated, completion: completion)
    }

    func embed(_ viewController: UIViewController,
               in container: EmbedContainer,
               options: TransitionOptions = .default,
               completion: NavigationHandler? = nil) {

        container.viewController.addChild(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: container.view.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: container.view.bottomAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: container.view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: container.view.trailingAnchor)
        ])

        viewController.didMove(toParent: container.viewController)
        completion?()
    }

    // MARK: - Private

    private var topPresentedViewController: UIViewController {
         return presentedViewController?.topPresentedViewController ?? self
     }
}
