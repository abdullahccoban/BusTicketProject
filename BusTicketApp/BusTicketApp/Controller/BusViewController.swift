//
//  BusViewController.swift
//  BusTicketApp
//
//  Created by Abdullah Coban on 26.07.2021.
//

import UIKit

class BusViewController: UIViewController {
    
    private let buyticketButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ticket"), for: .normal)
        button.addTarget(self, action: #selector(goPopUpPage(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView.register(BusCollectionViewCell.self, forCellWithReuseIdentifier: BusCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var bilet = Bilet()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.allowsMultipleSelection = true
        arrangeViews()
        setNavigationBar()
    }
    
    @objc func goPopUpPage(sender: UIButton!) {
        let popVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "popupVC") as! PopUpViewController
        
        popVC.bilet = bilet
        
        self.addChild(popVC)
        popVC.view.frame = self.view.frame
        self.view.addSubview(popVC.view)
        popVC.didMove(toParent: self)
    }
    
    private func arrangeViews() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        view.addSubview(buyticketButton)
        
        NSLayoutConstraint.activate([
            buyticketButton.widthAnchor.constraint(equalToConstant: 154),
            buyticketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buyticketButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buyticketButton.heightAnchor.constraint(equalToConstant: 137),
            collectionView.bottomAnchor.constraint(equalTo: buyticketButton.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
    }
}

extension BusViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 45
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let busCell = collectionView.dequeueReusableCell(withReuseIdentifier: BusCollectionViewCell.identifier, for: indexPath) as! BusCollectionViewCell
        busCell.configure(label: "\(indexPath.item + 1)")
        return busCell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        bilet.koltuk.append(indexPath.row + 1)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        cell?.backgroundColor = .systemGreen
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let index = bilet.koltuk.firstIndex(of: indexPath.row + 1) {
            bilet.koltuk.remove(at: index)
        }
        let cell = collectionView.cellForItem(at: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
        cell?.backgroundColor = .clear
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.indexPathsForSelectedItems?.count ?? 0 == bilet.koltukSayisi {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen belirtilen koltuk sayısı kadar seçin.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return collectionView.indexPathsForSelectedItems?.count ?? 0 <= (bilet.koltukSayisi - 1)
        }
        return true
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3.0
        let height = width
        
        return CGSize(width: width, height: height)
    }
}

extension BusViewController {
    func setNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
}
