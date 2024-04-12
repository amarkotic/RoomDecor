struct SkillListModel {

    let title: String
    let skills: [SkillModel]

}

extension SkillListModel {

    static var technicalSkills: SkillListModel {
        SkillListModel(
            title: "Technical Skills",
            skills: [
                SkillModel(name: "Mobile architectures"),
                SkillModel(name: "iOS development"),
                SkillModel(name: "Advanced Custom UI's"),
                SkillModel(name: "SwiftUI"),
                SkillModel(name: "UIKit"),
                SkillModel(name: "Reactive programming"),
                SkillModel(name: "GitFlow"),
                SkillModel(name: "CI/CD"),
                SkillModel(name: "App Store"),
                SkillModel(name: "RESTful API"),
                SkillModel(name: "Payment systems")])
    }

    static var interpersonalSkills: SkillListModel {
        SkillListModel(
            title: "Interpersonal Skills",
            skills: [
                SkillModel(name: "Leadership"),
                SkillModel(name: "Communication"),
                SkillModel(name: "Mentoring"),
                SkillModel(name: "Critical Thinking"),
                SkillModel(name: "Scrum/Agile"),
                SkillModel(name: "English"),
                SkillModel(name: "German")])
    }

}
