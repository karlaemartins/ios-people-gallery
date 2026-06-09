//
//  PeopleViewController.swift
//  PeopleGallery
//
//  Created by Karla E. Martins Fernandes on 01/06/26.
//

import UIKit

final class PeopleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var collectionView: UICollectionView!
    private let imageStorageService = ImageStorageService()
    private let personStorageService = PersonStorageService()
    
    private var people: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "People Gallery"
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        configureNavigationBar()
        people = personStorageService.loadPeople()
    }
    
    @objc private func addNewPerson() {
        
        let picker = UIImagePickerController()
           
           picker.allowsEditing = true
           picker.delegate = self
           
           present(picker, animated: true)
    }
    
    private func configureCollectionView() {
            
        let layout = UICollectionViewFlowLayout()
        
        let padding: CGFloat = 10
        let spacing: CGFloat = 10
        let availableWidth = view.bounds.width - (padding * 2) - spacing
        let cellWidth = availableWidth / 2

        layout.itemSize = CGSize(width: cellWidth, height: 180)
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 10, left: padding, bottom: 10, right: padding)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: PersonCell.reuseIdentifier)
        
        collectionView.dataSource = self

        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor)])
        
    }
    
    private func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[.editedImage] as? UIImage else {
            return
        }

        guard let imageName = imageStorageService.save(image: image) else {
            return
        }

        dismiss(animated: true) { [weak self] in
            self?.presentNameAlert(for: imageName)
        }
    }
    
    private func presentNameAlert(for imageName: String) {
        
        let alert = UIAlertController(title: "New Person", message: "Enter a name", preferredStyle: .alert)

        alert.addTextField()

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        alert.addAction(UIAlertAction(title: "Save", style: .default) { [weak self, weak alert] _ in
            
            guard let self else { return }
            guard let name = alert?.textFields?.first?.text else { return }

            let person = Person(id: UUID(), name: name, imageName: imageName)

            people.append(person)
            
            personStorageService.save(people: people)

            let indexPath = IndexPath(item: people.count - 1, section: 0)

            collectionView.insertItems(at: [indexPath])

        })

        present(alert, animated: true)

    }
}

extension PeopleViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return people.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.reuseIdentifier, for: indexPath) as? PersonCell
        else {
            fatalError("Unable to dequeue PersonCell.")
        }
        
        let person = people[indexPath.item]
        
        let image = imageStorageService.loadImage(named: person.imageName)

        cell.configure(name: person.name, image: image)

        return cell
    }
}
