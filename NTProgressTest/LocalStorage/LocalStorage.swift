//
//  LocalStorage.swift
//  TemplateOfDealsViewer
//
//  Created by Георгий Матченко on 23.02.2023.
//

import Foundation

class LocalStorage {
    static let shared = LocalStorage()
    
    // свойства для хранения параметра соритровки и направления
    var sortDerection: SortDerection = .first
    var currentSortType: SortType = .id
    let arraySortsType = [SortType.id, SortType.instrument, SortType.price, SortType.amount, SortType.side]
    
    func getDealsInStorage() -> [Deal]  {
        return model
    }
    
    func saveDeals(deals:[Deal]) {
        model += deals
    }
    
    private var model: [Deal] = []
    
    func sortModel(completion: @escaping () -> ()) {
        if sortDerection == .first {
            switch currentSortType {
            case .instrument:
                model.sort(by: {$0.instrumentName < $1.instrumentName})
            case .price:
                model.sort(by: {$0.price < $1.price})
            case .amount:
                model.sort(by: {$0.amount < $1.amount})
            case .side:
                let buy = model.filter({$0.side == .buy})
                let sell = model.filter({$0.side == .sell})
                model.removeAll()
                model += sell
                model += buy
            case .id:
                model.sort(by: {$0.id < $1.id})
            }
        } else {
            switch currentSortType {
            case .instrument:
                model.sort(by: {$0.instrumentName > $1.instrumentName})
            case .price:
                model.sort(by: {$0.price > $1.price})
            case .amount:
                model.sort(by: {$0.amount > $1.amount})
            case .side:
                let buy = model.filter({$0.side == .buy})
                let sell = model.filter({$0.side == .sell})
                model.removeAll()
                model += buy
                model += sell
            case .id:
                model.sort(by: {$0.id > $1.id})
            }
        }
        completion()
    }
    
}

