//
//  ViewController.swift
//  test
//

import UIKit

class ViewController: UIViewController {
//  fileprivate var slideUpController: SlideUpViewController?

  @IBAction private func showButtonDidTouch() {
    let contentView = ContentView(delegate: self)
    let slideUpController = SlideUpViewController(slideView: contentView, preferredHeight: 140)
    self.present(slideUpController, animated: true, completion: nil)
  }

  @IBAction fileprivate func showControllerButtonDidTouch(sender: UIButton!) {
    let controller = SelectViewController(delegate: self)
    let slideUpController = SlideUpViewController(viewController: controller)
    self.present(slideUpController, animated: true, completion: nil)
  }
}

extension ViewController: ContentViewDelegate {
  func dismissButtonDidTouch() {
    self.presentedViewController?.dismiss(animated: true, completion: nil)
  }
}

extension ViewController: SelectViewControllerDelegate {
  func didSelectNumber(_ number: Int) {
    self.presentedViewController?.dismiss(animated: true, completion: { 
      let alertController = UIAlertController(title: "User did select number", message: "\(number)", preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
        alertController.dismiss(animated: true, completion: nil)
      })
      alertController.addAction(action)

      self.present(alertController, animated: true, completion: nil)
    })
  }
}
