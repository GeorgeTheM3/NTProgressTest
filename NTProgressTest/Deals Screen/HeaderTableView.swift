//
//  HeaderTableView.swift
//  TemplateOfDealsViewer
//
//  Created by Георгий Матченко on 22.02.2023.
//

import UIKit

class HeaderTableView: UITableViewHeaderFooterView {
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
        label.textAlignment = .center
        label.text = "Instrument"
        label.font = Constants.fontHeader
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Price"
        label.font = Constants.fontHeader
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Amount"
        label.font = Constants.fontHeader
        return label
    }()
    
    private lazy var sideLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Side"
        label.font = Constants.fontHeader
        return label
    }()
    
    private func appendSubviewsToView() {
        addSubview(dealInfoStackView)
    }
    
    private func setConstraintsOfSubviews() {
        NSLayoutConstraint.activate([
            dealInfoStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            dealInfoStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        appendSubviewsToView()
        setConstraintsOfSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

