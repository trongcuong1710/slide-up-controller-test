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
  fileprivate var slideViewBottomConstraint: NSLayoutConstraint!
  
  init(slideView: UIView) {
    super.init(nibName: "SlideUpViewController", bundle: Bundle.main)
    self.slideView = slideView
    self.modalPresentationStyle = .overCurrentContext
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
  
  func dismiss() {
    self.animateSlideViewOut { [unowned self] in
      self.dismiss(animated: false, completion: nil)
    }
  }
}

extension SlideUpViewController {
  fileprivate func animateSlideViewIn(completion: (() -> ())? = nil) {
    UIView.animate(withDuration: 0.3, animations: { [unowned self] in
      self.backgroundView.alpha = 1
      self.slideView.transform = CGAffineTransform.identity
    })
  }
  
  fileprivate func animateSlideViewOut(completion: (() -> ())? = nil) {
    UIView.animate(withDuration: 0.3, animations: { [unowned self] in
      self.backgroundView.alpha = 0
      self.slideView.transform = CGAffineTransform(translationX: 0, y: self.slideView.frame.height)
    }) { (completed) in
      completion?()
    }
  }
  
  fileprivate func setupSlideView() {
    self.addSlideViewToStack()
    self.setSlideViewContraints()
    self.slideView.transform = CGAffineTransform(translationX: 0, y: self.slideView.frame.height)
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
    
    self.slideViewBottomConstraint = NSLayoutConstraint(item: self.slideView,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: self.view,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: 0)
    
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
    self.view.addConstraints([self.slideViewBottomConstraint, leading, trailing])
  }
}
