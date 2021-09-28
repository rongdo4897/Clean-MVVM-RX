//
//  GithubCell.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import UIKit
import Kingfisher

protocol GithubCellDelegate: AnyObject {
    func tapContentView(_ cell: GithubCell, didTapWith viewModel: GitHubCellViewModel)
    func tapImage(_ cell: GithubCell, didTapWith viewModel: GitHubCellViewModel)
}

class GithubCell: BaseTBCell {
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    private var viewModel: GitHubCellViewModel?
    weak var delegate: GithubCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        initComponents()
        customizeComponents()
    }
}

//MARK: - Action - Obj
extension GithubCell {
    @objc private func tapContenView() {
        guard let viewModel = viewModel else {return}
        viewModel.name = "test"
        
        prepareForReuse()
        setUpdata(with: viewModel)
        
        delegate?.tapContentView(self, didTapWith: viewModel)
    }
    
    @objc private func tapImage() {
        
    }
}

//MARK: - Các hàm khởi tạo, Setup
extension GithubCell {
    private func initComponents() {
        initViews()
        initImages()
    }
    
    private func initViews() {
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapContenView)))
    }
    
    private func initImages() {
        imgUser.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImage)))
    }
}

//MARK: - Customize
extension GithubCell {
    private func customizeComponents() {
        
    }
}

//MARK: - Các hàm chức năng
extension GithubCell {
    func setUpdata(with viewModel: GitHubCellViewModel) {
        self.viewModel = viewModel
        loadImageWithUrl(urlStr: viewModel.imageUrl)
        lblName.text = viewModel.name
        lblType.text = viewModel.type
        lblScore.text = viewModel.score
    }
    
    func loadImageWithUrl(urlStr: String?) {
        if let urlStr = urlStr, let url = URL(string: urlStr) {
            imgUser.kf.setImage(with: url)
        } else {
            imgUser.image = #imageLiteral(resourceName: "ic_default")
        }
    }
    
    override func prepareForReuse() {
        imgUser.image = nil
        lblScore.text = nil
        lblName.text = nil
        lblType.text = nil
    }
}
