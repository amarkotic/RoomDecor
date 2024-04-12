import UIKit
import SnapKit
import CoreUi

extension AuthorViewController {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)

        contentView = UIView()
        scrollView.addSubview(contentView)

        stackView = UIStackView()
        contentView.addSubview(stackView)

        headerView = HeaderView()
        stackView.addArrangedSubview(headerView)

        firstDividerView = DividerView()
        stackView.addArrangedSubview(firstDividerView)

        technicalSkillsList = SkillsListView(viewModel: .technicalSkills)
        stackView.addArrangedSubview(technicalSkillsList)

        interpersonalSkillsList = SkillsListView(viewModel: .interpersonalSkills)
        stackView.addArrangedSubview(interpersonalSkillsList)

        secondDividerView = DividerView()
        stackView.addArrangedSubview(secondDividerView)

        publishedProjectsList = ProjectsListView(viewModel: .publishedProjectsModel)
        stackView.addArrangedSubview(publishedProjectsList)

        notableProjectsList = ProjectsListView(viewModel: .notableProjectsModel)
        stackView.addArrangedSubview(notableProjectsList)
    }

    public func styleViews() {
        view.backgroundColor = .white

        navigationController?.setNavigationBarHidden(false, animated: false)

        scrollView.showsVerticalScrollIndicator = false

        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
    }

    public func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }

}
