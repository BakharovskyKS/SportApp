// SearchViewController.swift
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource {
    
    private let searchBar = UISearchBar()
    private var typeCollectionView: UICollectionView!
    private var muscleCollectionView: UICollectionView!
    private let difficultySegmentedControl = UISegmentedControl(items: ["Beginner", "Intermediate", "Expert"])
    private let okButton = UIButton(type: .system)
    private let resultsTableView = UITableView()
    
    private var selectedType: String?
    private var selectedMuscle: String?
    private var selectedDifficulty: String?
    private var searchText: String?
    
    private var exercises: [String] = []
    
    private let mockExercises = [
        ("Jump Rope", "cardio", "calves", "beginner"),
        ("Bench Press", "strength", "chest", "intermediate"),
        ("Deadlift", "powerlifting", "hamstrings", "expert"),
        ("Squat", "strength", "quadriceps", "beginner"),
        ("Pull Up", "strength", "lats", "intermediate"),
        ("Plank", "stretching", "abdominals", "beginner"),
        ("Push Up", "strength", "chest", "beginner"),
        ("Snatch", "olympic_weightlifting", "shoulders", "expert")
    ]
    
    private var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        searchBar.placeholder = "Поиск упражнений"
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        let layoutType = UICollectionViewFlowLayout()
        layoutType.scrollDirection = .horizontal
        typeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutType)
        typeCollectionView.dataSource = self
        typeCollectionView.delegate = self
        typeCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "typeCell")
        view.addSubview(typeCollectionView)
        
        let layoutMuscle = UICollectionViewFlowLayout()
        layoutMuscle.scrollDirection = .horizontal
        muscleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutMuscle)
        muscleCollectionView.dataSource = self
        muscleCollectionView.delegate = self
        muscleCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "muscleCell")
        view.addSubview(muscleCollectionView)
        
        view.addSubview(difficultySegmentedControl)
        
        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        view.addSubview(okButton)
        
        resultsTableView.dataSource = self
        resultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "resultCell")
        view.addSubview(resultsTableView)
        
        toggleFilters(show: false)
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        typeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        muscleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        difficultySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        resultsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            typeCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            typeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            typeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            typeCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            muscleCollectionView.topAnchor.constraint(equalTo: typeCollectionView.bottomAnchor, constant: 10),
            muscleCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            muscleCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            muscleCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            difficultySegmentedControl.topAnchor.constraint(equalTo: muscleCollectionView.bottomAnchor, constant: 10),
            difficultySegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            difficultySegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            okButton.topAnchor.constraint(equalTo: difficultySegmentedControl.bottomAnchor, constant: 10),
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            resultsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func toggleFilters(show: Bool) {
        typeCollectionView.isHidden = !show
        muscleCollectionView.isHidden = !show
        difficultySegmentedControl.isHidden = !show
        okButton.isHidden = !show
        resultsTableView.isHidden = show
    }
    
    @objc private func okButtonTapped() {
        isExpanded = false
        toggleFilters(show: isExpanded)
        updateResults()
        
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // При каждом нажатии на строку поиска будем показывать фильтры
        isExpanded = true
        toggleFilters(show: isExpanded)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == typeCollectionView {
            return ["cardio", "olympic_weightlifting", "plyometrics", "powerlifting", "strength", "stretching", "strongman"].count
        } else {
            return ["abdominals", "biceps", "chest", "forearms", "glutes", "hamstrings", "lats", "quadriceps", "triceps"].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionView == typeCollectionView ? "typeCell" : "muscleCell", for: indexPath)
        cell.backgroundColor = .lightGray
        let label = UILabel()
        label.text = collectionView == typeCollectionView ? ["cardio", "olympic_weightlifting", "plyometrics", "powerlifting", "strength", "stretching", "strongman"][indexPath.row] :
            ["abdominals", "biceps", "chest", "forearms", "glutes", "hamstrings", "lats", "quadriceps", "triceps"][indexPath.row]
        label.sizeToFit()
        cell.contentView.addSubview(label)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == typeCollectionView {
            selectedType = ["cardio", "olympic_weightlifting", "plyometrics", "powerlifting", "strength", "stretching", "strongman"][indexPath.row]
        } else {
            selectedMuscle = ["abdominals", "biceps", "chest", "forearms", "glutes", "hamstrings", "lats", "quadriceps", "triceps"][indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        cell.textLabel?.text = exercises[indexPath.row]
        return cell
    }
    
    private func updateResults() {
        exercises = mockExercises
            .filter { exercise in
                (selectedType == nil || exercise.1 == selectedType) &&
                (selectedMuscle == nil || exercise.2 == selectedMuscle) &&
                (selectedDifficulty == nil || exercise.3 == selectedDifficulty) &&
                (searchText == nil || exercise.0.lowercased().contains(searchText!.lowercased()))
            }
            .map { $0.0 }
        
        resultsTableView.reloadData()
    }
}
