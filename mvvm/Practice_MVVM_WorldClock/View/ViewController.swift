//
//  ViewController.swift
//  Practice_MVVM_WorldClock
//
//  Created by eunbiiKim on 2022/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Loding..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yesterdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Yesterday", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.onYesterday(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var nowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Now", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.onNow(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var tomorrowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tomorrow", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.onTomorrow(_:)), for: .touchUpInside)
        return button
    }()
    
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        viewModel.onUpdated = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.timeLabel.text = self.viewModel.dateTimeString
            }
        }
        viewModel.reload()
    }
    
    @objc
    func onYesterday(_ sender: UIButton) {
        viewModel.moveDay(day: -1)
    }
    
    @objc
    func onNow(_ sender: UIButton) {
        timeLabel.text = "Loading..."
        viewModel.reload()
    }
    
    @objc
    func onTomorrow(_ sender: UIButton) {
        viewModel.moveDay(day: 1)
    }
}

extension ViewController {
    private
    func setupLayout() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(timeLabel)
        self.view.addSubview(yesterdayButton)
        self.view.addSubview(nowButton)
        self.view.addSubview(tomorrowButton)

        view.addConstraints([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            nowButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40),
            nowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nowButton.widthAnchor.constraint(equalToConstant: 100),
            
            yesterdayButton.trailingAnchor.constraint(equalTo: nowButton.leadingAnchor, constant: -15),
            yesterdayButton.centerYAnchor.constraint(equalTo: nowButton.centerYAnchor),
            yesterdayButton.widthAnchor.constraint(equalToConstant: 100),
            
            tomorrowButton.leadingAnchor.constraint(equalTo: nowButton.trailingAnchor, constant: 15),
            tomorrowButton.centerYAnchor.constraint(equalTo: nowButton.centerYAnchor),
            tomorrowButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}

