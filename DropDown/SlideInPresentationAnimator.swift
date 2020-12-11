//
//  SlideInPresentationAnimator.swift
//  DropDown
//
//  Created by Jawad Ali on 27/11/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
final class SlideInPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresentation: Bool
    
    init(isPresentation: Bool) {
        self.isPresentation = isPresentation
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        let controller = transitionContext.viewController(forKey: key)!
        let animationDuration = transitionDuration(using: transitionContext)
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        
        if isPresentation {
            dismissedFrame.origin.y -= presentedFrame.height
            transitionContext.containerView.addSubview(controller.view)
        }
        else{
            
            let height = ((controller.presentingViewController as? UINavigationController)?.navigationBar.frame.maxY ?? controller.presentingViewController?.navigationController?.navigationBar.bounds.maxY ?? 0) + 10
            
            dismissedFrame.origin.y -= dismissedFrame.height + height
        }
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        controller.view.frame = initialFrame
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                        controller.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
