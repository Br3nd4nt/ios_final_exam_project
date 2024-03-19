//
//  ContentViewController.swift
//  exam_app
//
//  Created by br3nd4nt on 19.03.2024.
//

import UIKit

class ContentViewController: UIViewController {
    
    private let notifications = Notification.Name(TabController.tileSizeNotif)
    
    private let viewModel = ContentViewModel()
    private var collectionView: UICollectionView!;
    private var isLoadingMore = false;
    private var tileSize: CGFloat = 0;
      override func viewDidLoad() {
        super.viewDidLoad()
          view.backgroundColor = TabController.bgColor
          setupCollectionView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTileSizeChange(notification:)), name: notifications, object: nil)
        fetchData()
      }
      
      private func setupCollectionView() {
          tileSize = self.view.frame.width - 40;
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .vertical
          self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) // Outlet to your collection view
          collectionView.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(collectionView)
          collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
          collectionView.pinLeft(to: view)
          collectionView.pinRight(to: view)
          collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
          collectionView.backgroundColor = .systemBackground
          
          collectionView.register(ContentViewCell.self, forCellWithReuseIdentifier: ContentViewCell.reuseId)
          collectionView.dataSource = self
          collectionView.delegate = self
      }
      
      private func fetchData() {
          isLoadingMore = true;
        Task {
          do {
            try await viewModel.fetchData()
            collectionView.reloadData()
              isLoadingMore = false
          } catch {
          }
        }
      }

    @objc func handleTileSizeChange(notification: Notification) {
        if let userInfo = notification.userInfo{
            let newSize = CGFloat((userInfo["newSize"] ?? 400) as! Float)
                print(newSize)
            self.tileSize = newSize;
            self.collectionView.reloadData()
        }
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self)
    }
}


extension ContentViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
      return viewModel.getContent().count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentViewCell.reuseId, for: indexPath) as! ContentViewCell // Replace with your cell identifier
    let content = viewModel.getContent()[indexPath.row]
    cell.configure(with: content) // Update cell UI with data from ViewModel
    return cell
  }
}


extension ContentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.tileSize, height: self.tileSize)
    }
}

extension ContentViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let contentOffset = scrollView.contentOffset
    let contentHeight = scrollView.contentSize.height
    let distanceFromBottom = contentHeight - contentOffset.y - scrollView.frame.size.height
    if distanceFromBottom < 200 && !isLoadingMore {
      fetchData()
    }
  }
}
