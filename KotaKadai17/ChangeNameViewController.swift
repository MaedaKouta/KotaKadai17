//
//  ChangeNameViewController.swift
//  KotaKadai17
//
//  Created by 前田航汰 on 2022/03/28.
//

import UIKit

protocol ChangeNameViewControllerDelegate: AnyObject {
    func changeName(name: String, index: Int)
}

class ChangeNameViewController: UIViewController {

    struct Target {
        let index: Int
        let name: String
    }

    private let alertAppear = AlertAppear()
    private var target: Target?
    weak var delegate: ChangeNameViewControllerDelegate?
    @IBOutlet private weak var nameTextField: UITextField!

    static func instatiateWithNavigationContoroller(delegate: ChangeNameViewControllerDelegate, target: Target) -> UINavigationController {
        let changeNameNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangeNameNC") as! UINavigationController
        let changeNameVC = changeNameNC.topViewController as! ChangeNameViewController
        changeNameVC.delegate = delegate
        changeNameVC.setData(target: target)
        return changeNameNC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let target = target else {
            assertionFailure("target is nil")
            return
        }
        nameTextField.text = target.name
    }

    @IBAction private func didTapSaveButton(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {
            let alert = alertAppear.setAlert(message: "値を入力してください")
            present(alert, animated: true)
            return
        }
        guard let target = target else {
            assertionFailure("target is nil")
            return
        }
        delegate?.changeName(name: name, index: target.index)
    }

    func setData(target: Target) {
        self.target = target
    }

}
