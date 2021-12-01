//
//  WordsTableViewCell.swift
//  English is simple
//
//  Created by Руслан on 28.11.2021.
//

import UIKit

class WordsTableViewCell: UITableViewCell {

    // MARK: - UI
    lazy private var wordLabel = UILabel()
    lazy private var phoneticLabel = UILabel()
    
    // Properties
    static let reuseIdentifier = String(describing: WordsTableViewCell.self)
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(wordLabel)
        contentView.addSubview(phoneticLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        wordLabel.text = nil
        phoneticLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        wordLabel.snp.makeConstraints { make in
            make.bottom.left.top.equalTo(contentView).inset(10)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
        }
        phoneticLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
            make.left.equalTo(wordLabel.snp.right)
            make.centerY.equalTo(wordLabel.snp.centerY)
        }
    }
    
    // MARK: - Configuration
    func configure(with wordsTableCellData: WordsTableCellData) {
        wordLabel.text = wordsTableCellData.word
        phoneticLabel.text = wordsTableCellData.phonetic
    }

}
