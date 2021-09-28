//
//  GithubViewController.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import UIKit

//MARK: - Outlet, Override
class GithubViewController: UIViewController {
    @IBOutlet weak var tblGithub: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    var viewModel: GithubViewModelProtocol?
    
    var listGithubs: [Github] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponents()
        customizeComponents()
        setUpData()
    }
}

//MARK: - Action - Obj
extension GithubViewController {
    @objc private func updateData() {
        viewModel?.refreshData()
    }
}

//MARK: - Các hàm khởi tạo, Setup
extension GithubViewController {
    private func initComponents() {
        initTableView()
    }
    
    private func initTableView() {
        GithubCell.registerCellByNib(tblGithub)
        tblGithub.dataSource = self
        tblGithub.delegate = self
        tblGithub.separatorInset.left = 0
        tblGithub.showsVerticalScrollIndicator = true
        tblGithub.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tblGithub.width, height: 0))
        
        if #available(iOS 10.0, *) {
            self.tblGithub.refreshControl = refreshControl
        } else {
            self.tblGithub.addSubview(refreshControl)
        }
        
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
    }
}

//MARK: - Customize
extension GithubViewController {
    private func customizeComponents() {
        
    }
}

//MARK: - Các hàm chức năng
extension GithubViewController {
    func setUpData() {
        viewModel?.listDataGitHub.bindAndFire({ listGithubs in
            self.listGithubs = listGithubs
            self.tblGithub.reloadData()
            self.refreshControl.endRefreshing()
        })
        
        viewModel?.isRefresh.bindAndFire({ isRefresh in
            if isRefresh {
                self.tblGithub.isHidden = true
            } else {
                self.tblGithub.isHidden = false
            }
        })
    }
}

//MARK: - TableView
extension GithubViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGithubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = GithubCell.loadCell(tableView) as? GithubCell else {return UITableViewCell()}
        let viewModel = GitHubCellViewModel(github: listGithubs[indexPath.row])
        cell.setUpdata(with: viewModel)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - GithubCellDelegate
extension GithubViewController: GithubCellDelegate {
    func tapContentView(_ cell: GithubCell, didTapWith viewModel: GitHubCellViewModel) {
        
    }
    
    func tapImage(_ cell: GithubCell, didTapWith viewModel: GitHubCellViewModel) {
        print(1)
    }
}
