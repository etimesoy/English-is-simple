//
//  WordsTableViewCell.swift
//  English is simple
//
//  Created by Руслан on 28.11.2021.
//

import UIKit

final class WordsTableViewCell: UITableViewCell {

    // MARK: - UI
    lazy private var wordLabel = UILabel()
    lazy private var phoneticLabel = UILabel()
    lazy private var audioButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(audioButtonDidTap), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties
    static let reuseIdentifier = String(describing: WordsTableViewCell.self)
    private var audioURL: String?
    private var audioPlayer: AudioPlayerProtocol = AudioPlayer()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(wordLabel)
        contentView.addSubview(phoneticLabel)
        contentView.addSubview(audioButton)

        layoutMargins = .zero
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
            make.width.equalTo(contentView).multipliedBy(0.5)
        }
        phoneticLabel.snp.makeConstraints { make in
            make.width.equalTo(contentView).multipliedBy(0.5)
            make.left.equalTo(wordLabel.snp.right)
            make.centerY.equalTo(wordLabel.snp.centerY)
        }
        audioButton.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(contentView).inset(5)
        }
    }

    // MARK: - Actions
    @objc private func audioButtonDidTap() {
        guard let audioURL = audioURL else { return }
        audioPlayer.playAudio(using: audioURL)
    }

    // MARK: - Configuration
    func configure(with wordsTableCellData: WordsTableCellData) {
        wordLabel.text = wordsTableCellData.word
        phoneticLabel.text = wordsTableCellData.phonetic
        audioURL = wordsTableCellData.audioURL
    }

}

