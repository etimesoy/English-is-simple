//
//  OnboardingPageViewController.swift
//  English is simple
//
//  Created by Руслан on 01.12.2021.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {

    // MARK: - UI
    lazy private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .systemGreen
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pagesViewControllers.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlDidTap(_:)), for: .valueChanged)
        return pageControl
    }()

    lazy private var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(nextButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties
    private var pagesViewControllers: [OnboardingViewController] = []
    private let homeViewController: UIViewController

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        configurePages()
        configureSubviews()
        configureConstraints()
    }

    // MARK: - Initializers
    init(_ homeViewController: UIViewController) {
        self.homeViewController = homeViewController
        homeViewController.modalPresentationStyle = .fullScreen
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration methods
    private func configurePages() {
        var pagesData: [OnboardingPageData] = []
        pagesData.append(OnboardingPageData(
            title: "Search words",
            description: "You can search for words phonetics in \"🔍 Search\" section. Press on the row with the word to add it to favourites.",
            image: UIImage(named: "SearchWordsImage")
        ))
        pagesData.append(OnboardingPageData(
            title: "Favourite words",
            description: "You can find you favourite words in \"★ Favourites\" section. Press on the row with the word to add it to favourites.",
            image: UIImage(named: "FavouriteWordsImage")
        ))
        pagesViewControllers = pagesData.map { pageData in
            return OnboardingViewController(pageData)
        }
        setViewControllers([pagesViewControllers[0]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }

    private func configureSubviews() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
    }

    private func configureConstraints() {
        nextButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Actions
    @objc private func pageControlDidTap(_ sender: UIPageControl) {
        setViewControllers([pagesViewControllers[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        updateNextButtonTitle()
    }

    @objc private func nextButtonDidTap(_ sender: UIButton) {
        if sender.titleLabel?.text == "Finish" {
            nextButton.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(-80)
            }
            pagesViewControllers[pageControl.currentPage].animateDisappear { [weak self] in
                guard let self = self else { return }
                self.view.layoutIfNeeded()
            }
            present(self.homeViewController, animated: true, completion: nil)
            return
        }
        pageControl.currentPage += 1
        guard let currentPage = viewControllers?.first,
              let nextPage = pageViewController(self, viewControllerAfter: currentPage) else {
                  return
              }
        setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)
        updateNextButtonTitle()
    }

    private func updateNextButtonTitle() {
        if pageControl.currentPage == pagesViewControllers.count - 1 {
            nextButton.setTitle("Finish", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }

}

// MARK: - PageViewController data source
extension OnboardingPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingViewController,
              let currentPageIndex = pagesViewControllers.firstIndex(of: viewController) else {
                  return nil
              }
//        let previousPageIndex = (pagesViewControllers.count + currentPageIndex - 1) % pagesViewControllers.count
//        return pagesViewControllers[previousPageIndex]
        return currentPageIndex > 0 ? pagesViewControllers[currentPageIndex - 1] : nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? OnboardingViewController,
              let currentPageIndex = pagesViewControllers.firstIndex(of: viewController) else {
                  return nil
              }
//        let nextPageIndex = (currentPageIndex + 1) % pagesViewControllers.count
//        return pagesViewControllers[nextPageIndex]
        return currentPageIndex < pagesViewControllers.count - 1 ? pagesViewControllers[currentPageIndex + 1] : nil
    }

}

// MARK: - PageViewController delegate
extension OnboardingPageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first as? OnboardingViewController,
              let currentIndex = pagesViewControllers.firstIndex(of: viewController) else {
                  return
              }
        pageControl.currentPage = currentIndex
        updateNextButtonTitle()
    }

}
