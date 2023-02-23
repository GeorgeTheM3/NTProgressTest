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
    
    // округляем стоимость до сотых
    private func formatPrice(price: Double) -> String {
        let numb = round(price * 100)/100
        return String(numb)
    }
    
    // убираем лишние обозначения валютных пар
    private func formatName(name: String) -> String {
        var transformString = name.map({$0})
        transformString.remove(at: 3)
        let result = String(transformString.prefix(while: {$0 != "_"}))
        return result
    }
    
    // определяем операцию и цвет
    private func transformSide(side: Deal.Side) -> String {
        if side == Deal.Side.buy {
            sideLabel.textColor = .systemGreen
            return "Buy"
        } else {
            sideLabel.textColor = .red
            return "Sell"
        }
    }
    
    // форматируем объем сделки
    private func transformAmount(amount: Double) -> String {
        let amount = Int(amount).formattedWithSeparator
        return String(amount)
    }
}

    // устанавливаем инфу в ячейку
extension DealCustomCell: PassInfoProtocol {
    func passInfo(dealInfo: Deal) {
        dealDateLabel.text = dealInfo.dateModifier.formatted()
        instrumentNameLabel.text = formatName(name: dealInfo.instrumentName)
        priceLabel.text = formatPrice(price: dealInfo.price)
        amountLabel.text = transformAmount(amount: dealInfo.amount)
        sideLabel.text = transformSide(side: dealInfo.side)
    }
}

