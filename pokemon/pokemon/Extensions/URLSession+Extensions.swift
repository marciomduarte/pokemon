//
//  URLSession+Extensions.swift
//  pokemon
//
//  Created by Márcio Duarte on 12/04/2022.
//

import Foundation

extension URLSession {

    public func newData(from url: URL) async throws -> (Data?, URLResponse, Error?){
        try await withCheckedThrowingContinuation { continuation in
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
