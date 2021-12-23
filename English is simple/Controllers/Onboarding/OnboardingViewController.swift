//
//  OnboardingViewController.swift
//  English is simple
//
//  Created by Руслан on 01.12.2021.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    // MARK: - UI
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    lazy private var functionalityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        configureConstraints()
    }

    // MARK: - Initializers
    init(_ onboardingPageData: OnboardingPageData) {
        super.init(nibName: nil, bundle: nil)

        titleLabel.text = onboardingPageData.title
        functionalityImageView.image = onboardingPageData.image
        descriptionLabel.text = onboardingPageData.description
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func configureViews() {
        view.addSubview(titleLabel)
        view.addSubview(functionalityImageView)
        view.addSubview(descriptionLabel)

        view.backgroundColor = #colorLiteral(red: 0.8838228137, green: 1, blue: 0.8613841428, alpha: 1)
    }

    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        functionalityImageView.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-35)
            make.right.left.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
    }

    // MARK: - Animation
    func animateDisappear(_ animations: @escaping () -> Void) {
        titleLabel.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(-80)
        }
        functionalityImageView.snp.updateConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let self = self else { return }
            self.view.backgroundColor = .white
            self.functionalityImageView.layer.opacity = 0
            self.descriptionLabel.layer.opacity = 0
            self.view.layoutIfNeeded()
            animations()
        }, completion: nil)
    }

}
