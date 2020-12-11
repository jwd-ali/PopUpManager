//
//  DimmedPopupPresentationController.swift
//  DropDown
//
//  Created by Jawad Ali on 27/11/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
final class DimmedPopupPresentationController: UIPresentationController {
    fileprivate var dimmingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.15)
        view.alpha = 0.0
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        
        guard let containerView = self.containerView else {return frame}
        
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView.bounds.size)
        
        frame.origin.x = (containerView.frame.width - frame.size.width) * 0.5
        frame.origin.y = ((presentingViewController as? UINavigationController)?.navigationBar.frame.maxY ?? presentingViewController.navigationController?.navigationBar.bounds.maxY ?? 0) + 10
        return frame
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmingView, at: 0)
        dimmingView
            .alignAllEdgesWithSuperview()

        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return presentedViewController.preferredContentSize
    }
    
}

// MARK: - dimming view
private extension DimmedPopupPresentationController {
    func setupDimmingView() {
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dimmingViewTapped(_:))))
    }
    
    @objc func dimmingViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        //if vc conforms to DimmingViewTappedProtocol, it can receive tap events
        if let vc = presentedViewController as? DimmingViewTappedProtocol {
            vc.dimmingViewTapped()
        }
    }
    
}

///conform to this protocol to receive dimming view tap events
protocol DimmingViewTappedProtocol: class {
    func dimmingViewTapped()
}
extension DimmingViewTappedProtocol where Self: UIViewController {
    func dimmingViewTapped(){
        dismiss(animated: true, completion: nil)
    }
}
