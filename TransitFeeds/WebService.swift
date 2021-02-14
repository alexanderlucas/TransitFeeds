//
//  WebService.swift
//  TransitFeeds
//
//  Created by Alex Lucas on 2/13/21.
//

import Foundation

public struct NoDataError: Error {}

struct WebService {

    static var shared: WebService = WebService()

    var jsonDecoder: JSONDecoder

    init() {
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func loadFeeds(completion: @escaping (Result<[Feed], Error>) -> ()) {
        guard let url = URL(string: "https://api.transitapp.com/v3/feeds?detailed=1") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in

            completion( Result {
                if let data = data {
                    let decodedResponse = try jsonDecoder.decode(FeedWrapper.self, from: data)
                    return decodedResponse.feeds
                }

                throw NoDataError()

            } )

        }.resume()

    }
}
