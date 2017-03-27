//
//  SlideUpViewController.swift
//  test
//
//  Created by Trong Cuong Doan on 3/24/17.
//  Copyright © 2017 Trong Cuong Doan. All rights reserved.
//

import UIKit

final class SlideUpViewController: UIViewController {
  @IBOutlet fileprivate weak var backgroundView: UIView!
  fileprivate var slideView: UIView!

  private init() {
    super.init(nibName: "SlideUpViewController", bundle: Bundle.main)
    self.modalPresentationStyle = .overCurrentContext
  }
  
  convenience init(slideView: UIView) {
    self.init()
    self.slideView = slideView

  }

  convenience init(viewController: UIViewController, preferredFrame: CGRect) {
    self.init()
    self.slideView = viewController.view
    self.slideView.translatesAutoresizingMaskIntoConstraints = false
    self.slideView.frame = preferredFrame
    self.addChildViewController(viewController)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupSlideView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.animateSlideViewIn()
  }
  
  func present(in viewController: UIViewController) {
    viewController.present(self, animated: false, completion: nil)
  }
  
  func dismiss(completion: (() -> Void)? = nil ) {
    self.animateSlideViewOut { [unowned self] in
      self.dismiss(animated: false, completion: nil)
      completion?()
    }
  }
}

extension SlideUpViewController {
  fileprivate func animateSlideViewIn(completion: (() -> ())? = nil) {
    UIView.animate(withDuration: 0.6,
                   delay: 0.0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0.0,
                   options: .curveEaseIn,
                   animations: { [unowned self] in
      self.backgroundView.alpha = 1
      self.slideView.center.y = self.slideView.center.y - self.slideView.frame.height
    })
  }
  
  fileprivate func animateSlideViewOut(completion: (() -> ())? = nil) {
    UIView.animate(withDuration: 0.3,
                   delay: 0.0,
                   usingSpringWithDamping: 1.0,
                   initialSpringVelocity: 0.0,
                   options: .curveEaseIn,
                   animations: { [unowned self] in
      self.backgroundView.alpha = 0
      self.slideView.center.y = self.slideView.center.y + self.slideView.frame.height
    }) { (_) in
      completion?()
    }
  }
  
  fileprivate func setupSlideView() {
    self.addSlideViewToStack()
    self.setSlideViewContraints()
  }
  
  private func addSlideViewToStack() {
    self.view.addSubview(self.slideView)
  }
  
  private func setSlideViewContraints() {
    let height = NSLayoutConstraint(item: self.slideView,
                                    attribute: .height,
                                    relatedBy: .equal,
                                    toItem: nil,
                                    attribute: .notAnAttribute,
                                    multiplier: 1.0,
                                    constant: self.slideView.frame.height)
    
    let bottom = NSLayoutConstraint(item: self.slideView,
                                    attribute: .bottom,
                                    relatedBy: .equal,
                                    toItem: self.view,
                                    attribute: .bottom,
                                    multiplier: 1.0,
                                    constant: self.slideView.frame.height)

    let leading = NSLayoutConstraint(item: self.slideView,
                                     attribute: .leading,
                                     relatedBy: .equal,
                                     toItem: self.view,
                                     attribute: .leading,
                                     multiplier: 1.0,
                                     constant: 0.0)
    
    let trailing = NSLayoutConstraint(item: self.slideView,
                                      attribute: .trailing,
                                      relatedBy: .equal,
                                      toItem: self.view,
                                      attribute: .trailing,
                                      multiplier: 1.0,
                                      constant: 0.0)
    
    self.slideView.addConstraint(height)
    self.view.addConstraints([bottom, leading, trailing])
  }
}
