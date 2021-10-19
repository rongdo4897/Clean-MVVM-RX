//
//  CategoryViewController.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 18/10/2021.
//

import UIKit
import RxSwift
import RxCocoa
import MGArchitecture
import NSObject_Rx
import Reusable

//MARK: - Outlet, Override
class CategoryViewController: UIViewController {
    @IBOutlet weak var tblCate: UITableView!
    
    var viewModel: CategoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponents()
        customizeComponents()
        bindViewModel()
    }
}

//MARK: - Các hàm khởi tạo, Setup
extension CategoryViewController {
    private func initComponents() {
        initTableView()
    }
    
    private func initTableView() {
        CategoryCell.registerCellByNib(tblCate)
        tblCate.separatorInset.left = 0
        tblCate.showsVerticalScrollIndicator = true
        tblCate.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tblCate.width, height: 0))
        tblCate.delegate = self
    }
}

//MARK: - Customize
extension CategoryViewController {
    private func customizeComponents() {
        
    }
}

//MARK: - Action - Obj
extension CategoryViewController {
    
}

//MARK: - Các hàm chức năng
extension CategoryViewController {
    
}

extension CategoryViewController: Bindable {
    func bindViewModel() {
        let input = CategoryViewModel.Input(loadTrigger: Driver.just(Void()),
                                            categorySelectedTrigger: tblCate.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input)
        
        output.categories
            .drive(tblCate.rx.items) { tableView, index, category in
                guard let cell = CategoryCell.loadCell(tableView) as? CategoryCell else {
                    return UITableViewCell()
                }
                cell.setUpData(data: category)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.categorySelected
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension CategoryViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard.init(name: Constants.category, bundle: nil)
}

//MARK: - TableView
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 3 / 4
    }
}
