//
//  ViewController.swift
//  test
//

import UIKit

class ViewController: UIViewController {
  fileprivate var slideUpController: SlideUpViewController?
  
  @IBAction private func showButtonDidTouch() {
    let contentView = ContentView(delegate: self)
    self.slideUpController = SlideUpViewController(slideView: contentView)
    self.slideUpController?.present(in: self)
  }
}

extension ViewController: ContentViewDelegate {
  func dismissButtonDidTouch() {
    self.slideUpController?.dismiss()
  }
}
