//
//  ChangeNameViewController.swift
//  KotaKadai17
//
//  Created by 前田航汰 on 2022/03/28.
//

import UIKit

class ChangeNameViewController: UIViewController {

    private let alertAppear = AlertAppear()
    private var target: CheckItem!
    private var didChange: ((CheckItem) -> Void)!
    @IBOutlet private weak var nameTextField: UITextField!

    static func instatiateWithNavigationContoroller(target: CheckItem, didChange: @escaping ((CheckItem) -> Void)) -> UINavigationController {
        let changeNameNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangeNameNC") as! UINavigationController
        let changeNameVC = changeNameNC.topViewController as! ChangeNameViewController
        changeNameVC.didChange = didChange
        changeNameVC.target = target
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
        didChange(.init(name: name, isChecked: target.isChecked))
    }

}
