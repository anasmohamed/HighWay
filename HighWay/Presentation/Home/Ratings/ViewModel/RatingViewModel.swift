//
//  RatingViewModel.swift
//  HighWay
//
//  Created by no one on 06/04/2021.
//

import Foundation
class RatingViewModel {
    
}
class RatingsListViewModel {
    
    private var ratingFirebaseManager = RatingFirbaseManager()
    private var ratings: [Rating] = [Rating]()
    {
        didSet{
            reloadTableView.value = ratings
        }
    }
    var numberOfItems: Int {
          return ratings.count
      }
    var reloadTableView: Observable<[Rating]> = Observable([])
    func fetchData() {
        ratingFirebaseManager.getRatings { [weak self] (success, ratings) in
              
            if success!{
                  self?.ratings = ratings
              }
              
//              self?.isLoading = false
          }
      }
    func getData(index: Int) -> Rating {
        return ratings[index]
    }
}
