//
//  HotelsCollectionViewController.swift
//  Tajawal
//
//  Created by Aleksei Neronov on 28.12.16.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import UIKit


class HotelsCollectionViewController: UICollectionViewController {

    private struct Storyboard {
        static let HotelCellIdentifier = "HotelCollectionCell"
        static let HotelCellNibIdentifier = "HotelCollectionViewCell"
        static let DetailSegue = "DetailSegue"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibs()
        setupCollectionView()
        title = "Hotels"

    }

    //MARK: Observe notification from Model
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(HotelsCollectionViewController.updateUI),
                                               name: .hotelsUpdated,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,
                                                  name: .hotelsUpdated,
                                                  object: nil);
    }

    @objc private func updateUI() {
        collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (REST.hotels?.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.HotelCellIdentifier, for: indexPath)
        if let hotel = REST.hotels?[indexPath.row] as Hotel? {
            if let hotelCell = cell as? HotelCollectionViewCell {
                hotelCell.hotel = hotel
            }
        }
    
        return cell
    }

    //MARK: - CollectionView UI Setup
    
    private func setupCollectionView(){
        let screenWidth = UIScreen.main.bounds.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }

    // Register cell classes
    private func registerNibs(){
        self.collectionView!.register(UINib(nibName: Storyboard.HotelCellNibIdentifier, bundle: nil), forCellWithReuseIdentifier: Storyboard.HotelCellIdentifier)
    }
    
    // MARK: UICollectionViewDelegate

    // Item is selected, segue to detail controller
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        performSegue(withIdentifier: Storyboard.DetailSegue, sender: REST.hotels?[indexPath.row])
        return true
    }

    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let hotel = sender as? Hotel {
            if let detailController = segue.destination as? DetailViewController {
                detailController.hotel = hotel
            }
        }
    }

}
