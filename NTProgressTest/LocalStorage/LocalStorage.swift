//
//  LocalStorage.swift
//  TemplateOfDealsViewer
//
//  Created by Георгий Матченко on 23.02.2023.
//

import Foundation

class LocalStorage {
    static let shared = LocalStorage()
    
    private var model: [Deal] = []
    private var dealCellsCount = 0 // для реализации инфинити скрола храним колличество ячеек таблицы
    
    // свойства для хранения параметра соритровки и направления
    var sortDerection: SortDerection = .first
    var currentSortType: SortType = .id
    let arraySortsType = [SortType.id, SortType.instrument, SortType.price, SortType.amount, SortType.side]
    
    func getDealsInStorage() -> [Deal]  {
        return model
    }
    
    // увеличиваем колличество отображаемых ячеек
    func addCells() {
        dealCellsCount += 30
    }
    
    func getDealCellsCount() -> Int {
        return dealCellsCount
    }
    
    func saveDeals(deals:[Deal]) {
        model += deals
    }
    
    func sortModel(completion: @escaping () -> ()) {
        let buy = model.filter({$0.side == .buy})
        let sell = model.filter({$0.side == .sell})
        switch currentSortType {
        case .instrument:
            sortDerection == .first ? model.sort(by: {$0.instrumentName < $1.instrumentName}) : model.sort(by: {$0.instrumentName > $1.instrumentName})
        case .price:
            sortDerection == .first ? model.sort(by: {$0.price < $1.price}) : model.sort(by: {$0.price > $1.price})
        case .amount:
            sortDerection == .first ? model.sort(by: {$0.amount < $1.amount}) : model.sort(by: {$0.amount > $1.amount})
        case .side:
            model.removeAll()
            model += sortDerection == .first ? buy : sell
            model += sortDerection == .first ? sell : buy
        case .id:
            sortDerection == .first ? model.sort(by: {$0.id < $1.id}) : model.sort(by: {$0.id > $1.id})
        }
        completion()
    }
    
}

