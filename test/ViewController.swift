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

  @IBAction fileprivate func showControllerButtonDidTouch(sender: UIButton!) {
    let controller = SelectViewController(delegate: self)
    self.slideUpController = SlideUpViewController(viewController: controller,
                                                   preferredFrame: CGRect(x: 0, y: 0, width: 375, height: 340))
    self.slideUpController?.present(in: self)
  }
}

extension ViewController: ContentViewDelegate {
  func dismissButtonDidTouch() {
    self.slideUpController?.dismiss()
  }
}

extension ViewController: SelectViewControllerDelegate {
  func didSelectNumber(_ number: Int) {
    self.slideUpController?.dismiss(completion: { 
      let alertController = UIAlertController(title: "User did select number", message: "\(number)", preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
        alertController.dismiss(animated: true, completion: nil)
      })
      alertController.addAction(action)

      self.present(alertController, animated: true, completion: nil)
    })
  }
}
