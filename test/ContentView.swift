//
//  ContentView.swift
//  test
//

import UIKit

@objc protocol ContentViewDelegate {
  func dismissButtonDidTouch()
}

class ContentView: UIView {
  @IBOutlet private weak var contentView: UIView!
  
  private weak var delegate: ContentViewDelegate?
  
  convenience init(delegate: ContentViewDelegate) {
    self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 141))
    self.delegate = delegate
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @IBAction private func dismissButtonDidTouch() {
    self.delegate?.dismissButtonDidTouch()
  }
  
  private func commonInit() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.contentView = UINib.init(nibName: "ContentView", bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as! UIView
    self.contentView.frame = self.bounds
    self.addSubview(self.contentView)
  }
}
