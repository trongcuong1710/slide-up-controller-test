//
//  SlideUpViewController.swift
//  test
//
//  Created by Trong Cuong Doan on 3/24/17.
//  Copyright © 2017 Trong Cuong Doan. All rights reserved.
//

import UIKit

let kSlideViewTag = 231

final class SlideUpViewController: UIViewController {
  fileprivate var slideView: UIView!
  fileprivate var preferredHeight: CGFloat!

  private init() {
    super.init(nibName: nil, bundle: nil)
    self.modalPresentationStyle = .overCurrentContext
    self.transitioningDelegate = self
  }
  
  convenience init(slideView: UIView, preferredHeight: CGFloat = 340) {
    self.init()
    self.preferredHeight = preferredHeight
    self.slideView = slideView
    self.slideView.tag = kSlideViewTag
    self.slideView.translatesAutoresizingMaskIntoConstraints = true
  }

  convenience init(viewController: UIViewController, preferredHeight: CGFloat = 340) {
    self.init(slideView: viewController.view, preferredHeight: preferredHeight)
    self.addChildViewController(viewController)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.setupView()
    self.setupSlideView()
  }
}

extension SlideUpViewController {
  fileprivate func setupView() {
    self.view = UIView(frame: UIScreen.main.bounds)
    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    self.view.alpha = 0
  }

  fileprivate func setupSlideView() {
    self.setSlideViewFrame()
    self.addSlideViewToStack()
  }

  private func setSlideViewFrame() {
    self.slideView.frame = CGRect(x: 0,
                                  y: UIScreen.main.bounds.height,
                                  width: UIScreen.main.bounds.width,
                                  height: self.preferredHeight)
  }
  
  private func addSlideViewToStack() {
    self.view.addSubview(self.slideView)
  }
}

extension SlideUpViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return SlideUpAnimator(isPresent: true)
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return SlideUpAnimator(isPresent: false)
  }
}
