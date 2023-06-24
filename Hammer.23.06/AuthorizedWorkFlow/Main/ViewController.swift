//
//  ViewController.swift
//  Hammer.23.06
//
//  Created by zalkarbek on 23/6/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
         let scrollView = UIScrollView()
         return scrollView
     }()
     
    private lazy var contentView: UIView = {
         let contentView = UIView()
         return contentView
     }()
     
   private  lazy var statusCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(
           StatusCollectionViewCell.self,
            forCellWithReuseIdentifier:
                StatusCollectionViewCell.reuseID)
        return view
    }()
     
     private  lazy var categoryCollectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .horizontal
          let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
          view.dataSource = self
          view.delegate = self
          view.register(
             CategoryCollectionViewCell.self,
              forCellWithReuseIdentifier:
             CategoryCollectionViewCell.reuseID)
          return view
      }()
     
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseID)
        return view
    }()
     
    private lazy var textLabel: UILabel = {
         let label = UILabel()
         label.text = "Moskva <>"
         label.numberOfLines = 0
         return label
     }()
     
     var status = [
         StatusModel(image: UIImage(named: "1")!),
         StatusModel(image: UIImage(named: "1")!)
     ]
     
    private var orderTypeArray = [CategoryModel]()
    private var takeAways = [ProductModel]() {
        didSet {
            filteredTakeAways = takeAways
        }
    }
    private var filteredTakeAways = [ProductModel]()
    
    private var smartphonesArray = [ProductModel]()
    private var laptopsArray = [ProductModel]()
    private var fragrancesArray = [ProductModel]()
    private var groceriesArray = [ProductModel]()
    private var homeDecorationArray = [ProductModel]()
    private var skincareArray = [ProductModel]()
    
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setupViews()
         setupLayout()
         configureTakeawaysDataArray()
         orderTypeArray = NetworkLayer.shared.decodeOrderTypeData(json)
     }
    
    private func configureCategoryArrays(indexPath: IndexPath) {
        let category = orderTypeArray[indexPath.row].orderLabel.lowercased()
        filteredTakeAways = takeAways.filter { $0.category == category }
    }
    
    private func handleconfigureCategoryArrays() {
        smartphonesArray = takeAways.filter({$0.category == "smartphones"})
        laptopsArray = takeAways.filter({$0.category == "laptops"})
        fragrancesArray = takeAways.filter({$0.category == "fragrances"})
        groceriesArray = takeAways.filter({$0.category == "groceries"})
        homeDecorationArray = takeAways.filter({$0.category == "home-decoration"})
        skincareArray = takeAways.filter({$0.category == "skincare"})
    }
     
    private func setupViews() {
         view.addSubview(scrollView)
         scrollView.addSubview(contentView)
        contentView.addSubview(categoryCollectionView)
        contentView.addSubview(statusCollectionView)
        contentView.addSubview(tableView)
        view.addSubview(textLabel)
     }
     
    private func setupLayout() {
        textLabel.snp.makeConstraints { make in
                   make.top.equalTo(view.snp.top).offset(30)
                    make.left.equalTo(view.snp.left).offset(10)
                    make.right.equalTo(view.snp.right).offset(-50)
                   make.bottom.equalTo(scrollView.snp.top).offset(0)
               }
        
        
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(50)
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(420)
            make.height.equalTo(900)
            make.top.equalTo(scrollView.snp.top).offset(20)
            make.left.equalTo(scrollView.snp.left).offset(5)
            make.right.equalTo(scrollView.snp.right).offset(-5)
            make.bottom.equalTo(scrollView.snp.bottom).offset(-20)
        }

        statusCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.bottom.equalTo(categoryCollectionView.snp.top).offset(-10)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(statusCollectionView.snp.top).offset(100)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.bottom.equalTo(tableView.snp.top).offset(-10)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(statusCollectionView.snp.top).offset(160)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom).inset(-10)
        }
     
     }
     

 }

 extension ViewController: UICollectionViewDataSource {
         
         func collectionView(
             _ collectionView: UICollectionView,
             numberOfItemsInSection section: Int
         ) -> Int {
             if collectionView == categoryCollectionView {
                 return orderTypeArray.count
             } else {
                 return status.count
             }
         }
         
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             if collectionView == categoryCollectionView {
                 guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CategoryCollectionViewCell.reuseID,
                    for: indexPath) as? CategoryCollectionViewCell else { fatalError() }
                 
                 let order = orderTypeArray[indexPath.row]
                 cell.displayCategory(item: order)
                 return cell
             } else {
                 guard let cell = collectionView.dequeueReusableCell(
                     withReuseIdentifier: StatusCollectionViewCell.reuseID,
                     for: indexPath) as? StatusCollectionViewCell else { fatalError() }
                 
                 let status = status[indexPath.row]
                 cell.displayStatus(item: status)
                 return cell
             }
         }
     }

 extension ViewController: UICollectionViewDelegateFlowLayout {
         func collectionView (
             _ collectionView: UICollectionView,
             layout collectionViewLayout: UICollectionViewLayout,
             sizeForItemAt indexPath: IndexPath
         ) -> CGSize {
             if collectionView == categoryCollectionView {
                 return CGSize(width: 150, height: 50)
             } else {
                 return CGSize(width: 300, height: 170)
             }
         }
         
         func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
             configureCategoryArrays(indexPath: indexPath)
             tableView.reloadData()
         }
     }

 extension ViewController: UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return filteredTakeAways.count
     }
     
     
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(
             withIdentifier: ProductTableViewCell.reuseID,
             for: indexPath
         ) as? ProductTableViewCell else { return UITableViewCell() }
         let product = filteredTakeAways[indexPath.row]
         cell.displayProduct(item: product)
         return cell
     }
     
     
 }

 extension ViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 380.0
     }


}

extension ViewController {
    private func configureTakeawaysDataArray() {
        NetworkLayer.shared.fetchProductsData { result in
            switch result {
            case .success(let model):
                self.takeAways = model.products
                self.handleconfigureCategoryArrays()
                DispatchQueue.main.async { [self] in
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
