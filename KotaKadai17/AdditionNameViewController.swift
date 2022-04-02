//
//  AdditionNameViewController.swift
//  KotaKadai17
//
//  Created by 前田航汰 on 2022/03/28.
//

import UIKit

class AdditionNameViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    private let alertAppear = AlertAppear()
    private var didAdd: ((CheckItem) -> Void)!

    static func instantiateWithNavigationController(didAdd: @escaping (CheckItem) -> Void) -> UINavigationController {
        let additionNameNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdditionNameNC") as! UINavigationController
        let additionNameVC = additionNameNC.topViewController as! AdditionNameViewController
        additionNameVC.didAdd = didAdd
        return additionNameNC
    }

    @IBAction private func didTapSaveButton(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {
            let alert = alertAppear.setAlert(message: "値を入力してください")
            present(alert, animated: true)
            return
        }
        didAdd(.init(name: name, isChecked: false))
    }

}
