//
//  SelectedTypeCollectionViewController.swift
//  SportApp
//
//  Created by Кирилл Бахаровский on 11/9/24.
//

import UIKit

class SelectedTypeCollectionViewController: UIViewController {
    
    var didSelectItem: ((String) -> Void)?
    
    private let reuseIdentifier = "SelectedTypeCollectionViewCell"
    var array: [String] = []
    private var selectedIndexPath: IndexPath?
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = 16
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(array: [String]?) {
        self.array = array ?? []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegate()
        
        collectionView.register(SelectedTypeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    private func setDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension SelectedTypeCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SelectedTypeCollectionViewCell
        cell.configure(text: array[indexPath.row])
        
        if indexPath == selectedIndexPath {
            cell.contentView.backgroundColor = .green
        } else {
            cell.contentView.backgroundColor = .lightGray
        }
        
        return cell
    }
    
    
}

extension SelectedTypeCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
            didSelectItem?("")
        } else {
            selectedIndexPath = indexPath
            didSelectItem?(array[indexPath.row])
        }
        
        
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}

extension SelectedTypeCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = array[indexPath.row]
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12)
        
        let maxWidth = collectionView.frame.width - 32
        let maxSize = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let textSize = label.sizeThatFits(maxSize)
        
        return CGSize(width: textSize.width + 32, height: textSize.height + 16)
    }
}

extension SelectedTypeCollectionViewController {
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
