//
//  Repository.swift
//  Practice_MVVM_WorldClock
//
//  Created by eunbiiKim on 2022/11/22.
//

import Foundation

class Repository {
    func fetchNow(onCompleted: @escaping (UtcTimeModel) -> Void) {
        let url = "http://worldclockapi.com/api/json/utc/now"

        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: data) else { return }
            onCompleted(model)
        }.resume()
    }
}
