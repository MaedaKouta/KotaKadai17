//
//  ViewController.swift
//  KotaKadai17
//
//  Created by 前田航汰 on 2022/03/28.
//

import UIKit

struct CheckItem {
    var name: String
    var isChecked: Bool
}

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var checkItems: [CheckItem] = [
        .init(name: "みかん", isChecked: false),
        .init(name: "りんご", isChecked: true),
        .init(name: "バナナ", isChecked: false),
        .init(name: "パイナップル", isChecked: true)
    ]

    // itemの追加画面へ遷移
    @IBAction private func didTapAddNameButton(_ sender: Any) {
        present(
            AdditionNameViewController.instantiateWithNavigationController(delegate: self),
            animated: true,
            completion: nil
        )
    }

    @IBAction func exitCansel(segue: UIStoryboardSegue) {
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CheckItemsTableViewCell
        cell.config(checkItem: checkItems[indexPath.row])
        return cell
    }

    // チェックマークの表示切り替え
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkItems[indexPath.row].isChecked.toggle()
        tableView.reloadData()
    }

    // itemの変更画面へ遷移
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        present(
            ChangeNameViewController.instatiateWithNavigationContoroller(
                delegate: self,
                target: .init(
                    index: indexPath.row,
                    name: checkItems[indexPath.row].name
                )
            ),
            animated: true,
            completion: nil
        )
    }

    // セルの削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            checkItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}

extension ViewController: AdditionNameViewControllerDelegate, ChangeNameViewControllerDelegate {

    func addName(name: String) {
        checkItems.append(.init(name: name, isChecked: false))
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }

    func changeName(name: String, index: Int) {
        checkItems[index].name = name
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }

}
