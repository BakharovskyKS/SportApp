//
//  ExerciseTableViewCell.swift
//  SportApp
//
//  Created by Кирилл Бахаровский on 11/10/24.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "type"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let muscleLabel: UILabel = {
        let label = UILabel()
        label.text = "muscle"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let equipmentLabel: UILabel = {
        let label = UILabel()
        label.text = "equipment"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.text = "difficulty"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = "instructions"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 0.1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.clipsToBounds = true
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func configure(exercise: ExercisesModel) {
        nameLabel.text = "Name: \(exercise.name ?? "Empty")"
        typeLabel.text = "Type: \(exercise.type ?? "Empty")"
        muscleLabel.text = "Muscle: \(exercise.muscle ?? "Empty")"
        equipmentLabel.text = "Equipment: \(exercise.equipment ?? "Empty")"
        difficultyLabel.text = "Difficulty: \(exercise.difficulty ?? "Empty")"
        instructionsLabel.text = "Instructions: \(exercise.instructions ?? "Empty")"
    }
    
}

extension ExerciseTableViewCell {
    private func setupViews(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(muscleLabel)
        contentView.addSubview(equipmentLabel)
        contentView.addSubview(difficultyLabel)
        contentView.addSubview(instructionsLabel)

    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            muscleLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            muscleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            muscleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            equipmentLabel.topAnchor.constraint(equalTo: muscleLabel.bottomAnchor, constant: 10),
            equipmentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            equipmentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            difficultyLabel.topAnchor.constraint(equalTo: equipmentLabel.bottomAnchor, constant: 10),
            difficultyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            difficultyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: difficultyLabel.bottomAnchor, constant: 10),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            instructionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])

    }
}
