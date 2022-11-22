//
//  ViewModel.swift
//  Practice_MVVM_WorldClock
//
//  Created by eunbiiKim on 2022/11/22.
//

import Foundation


class ViewModel {
    var onUpdated: () -> Void = {}
    
    var dateTimeString: String = "Loading..."
    {
        didSet {
            onUpdated()
        }
    }
    
    let service = Service()
    
    func reload() {
        print(#function)
        service.fetchNow { [weak self] model in
            print("service.fetchNow")
            if let dateString = self?.dateToString(date: model.currentDateTime) {
                self?.dateTimeString = dateString
            } else {
                print("없습니다")
            }
        }
    }

    func moveDay(day: Int) {
        service.moveDay(day: day)
        self.dateTimeString = dateToString(date: service.currentModel.currentDateTime)
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date)
    }
}
