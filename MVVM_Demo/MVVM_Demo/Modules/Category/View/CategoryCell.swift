//
//  CategoryCell.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 18/10/2021.
//

import UIKit
import Kingfisher

class CategoryCell: BaseTBCell {
    @IBOutlet weak var imgCate: UIImageView!
    @IBOutlet weak var lblCate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpData(data: Category) {
        imgCate.kf.setImage(with: URL(string: data.strCategoryThumb ?? ""))
        lblCate.text = data.strCategory
    }
}
