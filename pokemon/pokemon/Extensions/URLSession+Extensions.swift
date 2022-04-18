//
//  URLSession+Extensions.swift
//  pokemon
//
//  Created by Márcio Duarte on 12/04/2022.
//

import Foundation

extension URLSession {

    // iOS 13 and 14 doens't support async mehtod and to skip this problem we create a wrapper around URLSession.
    public func getData(from url: URL) async throws -> (Data?, URLResponse, Error?){
        try await withCheckedContinuation { continuation in
            self.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.notConnectedToInternet)
                    return continuation.resume(returning: (Data(), URLResponse(), error))
                }

                continuation.resume(returning: (data, response, nil))
            }.resume()
        }
    }
}
