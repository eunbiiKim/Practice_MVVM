//
//  Logic.swift
//  Practice_MVVM_WorldClock
//
//  Created by eunbiiKim on 2022/11/22.
//

import Foundation

class Service {
    let repository = Repository()
    
    var currentModel = Model(currentDateTime: Date())
    
    func fetchNow(onCompleted: @escaping (Model) -> Void) {
        repository.fetchNow { [weak self] entity in
            // entity를 Model로 변경해주는 로직을 여기서 처리
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
            
            guard let now = formatter.date(from: entity.currentDateTime) else { return }
            
            let model = Model(currentDateTime: now)
            self?.currentModel = model
            
            onCompleted(model)
        }
    }
    
    func moveDay(day: Int) {
        guard let movedDay = Calendar.current.date(byAdding: .day,
                                                   value: day,
                                                   to: currentModel.currentDateTime) else {
            return
        }
        currentModel.currentDateTime = movedDay
    }
}
