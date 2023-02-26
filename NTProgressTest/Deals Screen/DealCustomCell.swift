//
//  DealCustomCell.swift
//  TemplateOfDealsViewer
//
//  Created by Георгий Матченко on 22.02.2023.
//

import Foundation
import UIKit

class DealCustomCell: UITableViewCell {
    private lazy var dealDateLabel: UILabel = {
        let label = UILabel()
        label.text = "13:43:56 09.12.2022"
        label.font = Constants.fontDate
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dealInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(instrumentNameLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(sideLabel)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var instrumentNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Constants.mainFont
        label.text = "USDRUB"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constants.mainFont
        label.text = "62.10"
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constants.mainFont
        label.text = "1 000 000"
        return label
    }()
    
    private lazy var sideLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constants.mainFont
        label.text = "Sell"
        return label
    }()
    
    private func appendSubviewsToView() {
        addSubview(dealDateLabel)
        addSubview(dealInfoStackView)
    }
    
    private func setConstraintsOfSubviews() {
        NSLayoutConstraint.activate([
            dealDateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            dealDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            dealInfoStackView.topAnchor.constraint(equalTo: dealDateLabel.bottomAnchor),
            dealInfoStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            dealInfoStackView.heightAnchor.constraint(equalToConstant: 50),
            dealInfoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        appendSubviewsToView()
        setConstraintsOfSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // убираем лишние обозначения валютных пар
    private func setName(name: String) {
        var transformString = name.map({$0})
        transformString.remove(at: 3)
        instrumentNameLabel.text = String(transformString.prefix(while: {$0 != "_"}))
    }
    
    // округляем стоимость до сотых
    private func setPrice(price: Double) {
        let numb = round(price * 100)/100
        priceLabel.text = String(numb)
    }
    
    // форматируем объем сделки
    private func setAmount(amount: Double) {
        let amount = Int(amount).formattedWithSeparator
        amountLabel.text = String(amount)
    }
    
    // определяем операцию и цвет
    private func setTextSideLabel(side: Deal.Side) {
        sideLabel.text = side == Deal.Side.buy ? "Buy": "Sell"
        sideLabel.textColor = side == Deal.Side.buy ? .systemGreen : .red
    }
}

    // устанавливаем инфу в ячейку
extension DealCustomCell: PassInfoProtocol {
    func passInfo(dealInfo: Deal) {
        dealDateLabel.text = dealInfo.dateModifier.formatted(date: .numeric, time: .standard)
        setName(name: dealInfo.instrumentName)
        setPrice(price: dealInfo.price)
        setAmount(amount: dealInfo.amount)
        setTextSideLabel(side: dealInfo.side)
    }
}

