//
//  URLSession+Extensions.swift
//  pokemon
//
//  Created by Márcio Duarte on 12/04/2022.
//

import Foundation

extension URLSession {

    func data(from url: URL) async throws -> (Data, URLResponse){
        try await withCheckedContinuation({ continuation in
            self.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.unknown)
                    return continuation.resume(throwing: error as! Never)
                }

                continuation.resume(returning: (data, response))
            }.resume()
        })
    }

}
