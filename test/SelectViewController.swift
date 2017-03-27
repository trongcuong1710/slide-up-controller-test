//
//  SelectViewController.swift
//  test
//

import UIKit

@objc protocol SelectViewControllerDelegate {
  func didSelectNumber(_ number: Int)
}

class SelectViewController: UIViewController {
  @IBOutlet fileprivate weak var tableView: UITableView!

  var delegate: SelectViewControllerDelegate?

  init(delegate: SelectViewControllerDelegate) {
    super.init(nibName: "SelectViewController", bundle: Bundle.main)
    self.delegate = delegate
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.reloadData()
  }
}

extension SelectViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44))
    let label = UILabel()
    label.text = "\(indexPath.row)"
    label.sizeToFit()
    label.center = cell.contentView.center

    cell.contentView.addSubview(label)

    return cell
  }
}

extension SelectViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.delegate?.didSelectNumber(indexPath.row)
  }
}
