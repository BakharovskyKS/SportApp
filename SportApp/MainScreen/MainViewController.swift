//
//  MainViewController.swift
//  SportApp
//
//  Created by Кирилл Бахаровский on 11/9/24.
//

import UIKit

class MainViewController: UIViewController {
    
    let type = [
        "cardio", "olympic_weightlifting", "plyometrics",
        "powerlifting", "strength", "stretching", "strongman"
    ]
    
    let muscles = [
        "abdominals", "abductors", "adductors",
        "biceps", "calves", "chest",
        "forearms", "glutes", "hamstrings",
        "lats", "lower_back", "middle_back",
        "neck", "quadriceps", "traps", "triceps"
    ]
    
    let difficulty = [
        "beginner", "intermediate", "expert"
    ]
    
    private let idTableViewCell = "ExerciseTableViewCell"
    private var exercises: [ExercisesModel] = []
    
    private var selectType = ""
    private var selectMuscle = ""
    private var selectDiffuclty = ""
    
    
    private let searchController = UISearchController()
    private var typeCollectionView: SelectedTypeCollectionViewController!
    private var muscleCollectionView: SelectedTypeCollectionViewController!
    private var difficultyCollectionView: SelectedTypeCollectionViewController!
    
    private lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Поиск", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackViewSearch: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        typeCollectionView = SelectedTypeCollectionViewController(array: type)
        muscleCollectionView = SelectedTypeCollectionViewController(array: muscles)
        difficultyCollectionView = SelectedTypeCollectionViewController(array: difficulty)
        
        setupViews()
        setConstraints()
        setupSearchController()
        setDelegate()
        setupSelectClosures()
        resultsTableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: idTableViewCell)
        
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for an exercise"
        searchController.obscuresBackgroundDuringPresentation = false // Чтобы таблица не затемнялась во время поиска
        searchController.searchBar.showsCancelButton = false
        
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    @objc func okButtonTapped() {
        print("okButtonTapped")
        searchController.searchBar.endEditing(true)
        toggleFilters(show: true)
        fetchData()
        
    }
    
    @objc func hide() {
        stackViewSearch.isHidden = true
        resultsTableView.isHidden = false
        searchController.searchBar.endEditing(true)
    }
    
    private func fetchData() {
        
        let name = searchController.searchBar.text
        
        NetworkService.shared.fetchExercises(name: name, type: selectType, muscle: selectMuscle, difficulty: selectDiffuclty) { [weak self] result in
            switch result {
            case .success(let exercises):
                self?.exercises = exercises
                DispatchQueue.main.async {
                    self?.resultsTableView.reloadData()
                    if exercises.isEmpty {
                        AlertService.shared.showAlert(title: "Данные с такими параметрами отсутствуют", message: "Повторите запрос с другими параметрами", on: self!)
                    }
                }
                
            case .failure(let error):
                print("Ошибка \(error.localizedDescription)")
            }
        }
    }
    
    func setupSelectClosures() {
            typeCollectionView.didSelectItem = { [weak self] value in
                self?.selectType = value
                print("Selected Type: \(self?.selectType ?? "")")
            }
            
            muscleCollectionView.didSelectItem = { [weak self] value in
                self?.selectMuscle = value
                print("Selected Muscle: \(self?.selectMuscle ?? "")")
            }
            
            difficultyCollectionView.didSelectItem = { [weak self] value in
                self?.selectDiffuclty = value
                print("Selected Difficulty: \(self?.selectDiffuclty ?? "")")
            }
        }
}


// MARK: UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

// MARK: UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("SearchBar")
        toggleFilters(show: false)
    }
    
    private func toggleFilters(show: Bool) {
        stackViewSearch.isHidden = show
        resultsTableView.isHidden = !show
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func setDelegate() {
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultsTableView.dequeueReusableCell(withIdentifier: idTableViewCell, for: indexPath) as? ExerciseTableViewCell else {
                    return UITableViewCell() }
        cell.configure(exercise: exercises[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}

// MARK: SetupViews and Constraints
extension MainViewController {
    private func setupViews() {
        view.addSubview(stackViewSearch)
        
        [typeCollectionView, muscleCollectionView, difficultyCollectionView].forEach { controller in
            addChild(controller)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            stackViewSearch.addArrangedSubview(controller.view)
        }
        
        stackViewSearch.addArrangedSubview(okButton)
        resultsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultsTableView)
        
        toggleFilters(show: true)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackViewSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackViewSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            typeCollectionView.view.heightAnchor.constraint(equalToConstant: 50),
            muscleCollectionView.view.heightAnchor.constraint(equalToConstant: 50),
            difficultyCollectionView.view.heightAnchor.constraint(equalToConstant: 50),
            okButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            resultsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

