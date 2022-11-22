//
//  ViewController.swift
//  Practice_MVVM_WorldClock
//
//  Created by eunbiiKim on 2022/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var currentDateTime = Date()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fetchNow()
    }
    
    @objc
    func onYesterday(_ sender: UIButton) {
        guard let yesterday = Calendar.current.date(byAdding: .day,
                                                    value: -1,
                                                    to: currentDateTime) else {
            return
        }
        currentDateTime = yesterday
        updateDateTime()
    }
    
    @objc
    func onNow(_ sender: UIButton) {
        fetchNow()
    }
    
    @objc
    func onTomorrow(_ sender: UIButton) {
        guard let tomorrow = Calendar.current.date(byAdding: .day,
                                                    value: 1,
                                                    to: currentDateTime) else {
            return
        }
        currentDateTime = tomorrow
        updateDateTime()
    }
}

extension ViewController {
    func fetchNow() {
        let url = "http://worldclockapi.com/api/json/utc/now"
        
        timeLabel.text = "Loading..."

        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { [weak self] data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
            
            guard let now = formatter.date(from: model.currentDateTime) else { return }
            
            self?.currentDateTime = now
            
            DispatchQueue.main.async {
                self?.updateDateTime()
            }
        }.resume()
    }
    
    private
    func updateDateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        self.timeLabel.text = formatter.string(from: currentDateTime)
    }
    
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

struct UtcTimeModel: Codable {
    let id: String
    let currentDateTime: String
    let utcOffset: String
    let isDayLightSavingsTime: Bool
    let dayOfTheWeek: String
    let timeZoneName: String
    let currentFileTime: Int
    let ordinalDate: String
    let serviceResponse: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case currentDateTime
        case utcOffset
        case isDayLightSavingsTime
        case dayOfTheWeek
        case timeZoneName
        case currentFileTime
        case ordinalDate
        case serviceResponse
    }
}

