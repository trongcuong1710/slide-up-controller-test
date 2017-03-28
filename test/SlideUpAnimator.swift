//
//  SlideUpAnimator.swift
//  test
//

import UIKit

class SlideUpAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  let isPresent: Bool
  let duration: TimeInterval = 0.3

  init(isPresent: Bool) {
    self.isPresent = isPresent
  }

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    if self.isPresent {
      self.animatePresentationTransition(with: transitionContext)
    } else {
      self.animateDismissalTransition(with: transitionContext)
    }
  }

  fileprivate func animatePresentationTransition(with context: UIViewControllerContextTransitioning) {
    guard let presentedController = context.viewController(forKey: UITransitionContextViewControllerKey.to),
      let presentedView = context.view(forKey: UITransitionContextViewKey.to),
      let animateView = presentedView.subview(by: kSlideViewTag) else {
        return
    }

    let containerView = context.containerView
    presentedView.frame = context.finalFrame(for: presentedController)
    containerView.addSubview(presentedView)

    UIView.animate(withDuration: self.duration, animations: {
      presentedView.alpha = 1
      animateView.center.y -= animateView.frame.height
    }) { (finished) in
      context.completeTransition(finished)
    }
  }

  fileprivate func animateDismissalTransition(with context: UIViewControllerContextTransitioning) {
    guard let presentedView = context.view(forKey: UITransitionContextViewKey.from),
      let animateView = presentedView.subview(by: kSlideViewTag) else {
      return
    }

    UIView.animate(withDuration: self.duration, animations: {
      presentedView.alpha = 0
      animateView.center.y += animateView.frame.height
    }, completion: { (finished) in
      presentedView.removeFromSuperview()
      context.completeTransition(finished)
    })
  }
}

extension UIView {
  func subview(by tag: Int) -> UIView? {
    return self.subviews.filter {
      return $0.tag == tag
    }.first
  }
}
