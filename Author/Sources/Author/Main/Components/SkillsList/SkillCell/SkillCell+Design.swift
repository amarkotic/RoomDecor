import SnapKit

extension SkillCell {

    public func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    public func createViews() {
        cardView = SkillCardView()
        contentView.addSubview(cardView)
    }

    public func styleViews() {}

    public func defineLayoutForViews() {
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
