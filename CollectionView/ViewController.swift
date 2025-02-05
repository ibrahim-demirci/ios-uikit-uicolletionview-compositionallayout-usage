//
//  ViewController.swift
//  ColletionView
//
//  Created by İbrahim on 5.02.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    // Section data
    let sections: [SectionModel] = [
        SectionModel(type: .story, itemsCount: 10),
        SectionModel(type: .paginate, itemsCount: 8),
        SectionModel(type: .paginateGrid, itemsCount: 8),
        SectionModel(type: .grid, itemsCount: 6),
        SectionModel(type: .instagramDiscovery, itemsCount: 8),
        SectionModel(type: .defaultSection, itemsCount: 5)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.dataSource = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            return self.createSectionLayout(for: sectionIndex)
        }
    }
    
    private func createSectionLayout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section = sections[sectionIndex]
        
        // Switch layout based on the section type
        switch section.type {
        case .story:
            return SectionFactory.createStorySection()
        case .paginate:
            return SectionFactory.createPaginateSection()
        case .instagramDiscovery:
            return SectionFactory.createDiscoverySection()
        case .grid:
            return SectionFactory.createGridSection()
        case .paginateGrid:
            return SectionFactory.createPaginateGridSection()
        case .defaultSection:
            return SectionFactory.createDefaultSection()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = sections[indexPath.section]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = cell.bounds
        gradientLayer.colors = [
            UIColor(red: 0.6, green: 0.8, blue: 1.0, alpha: 1.0).cgColor,
            UIColor(red: 0.8, green: 0.6, blue: 1.0, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        cell.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        cell.layer.insertSublayer(gradientLayer, at: 0)
        
        cell.layer.cornerRadius = radius(for: section)
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    
    func radius(for section: SectionModel) -> CGFloat {
        switch section.type {
        case .story:
            return 46
        case .instagramDiscovery:
            return 0
        case .grid:
            return 4
        default:
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as! HeaderView
            let section = sections[indexPath.section]
            headerView.configure(with: section.type.title)
            return headerView
        }
        return UICollectionReusableView()
    }
}

