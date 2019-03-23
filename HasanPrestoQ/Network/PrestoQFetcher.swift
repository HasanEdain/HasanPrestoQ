//
//  PrestoQFetcher.swift
//  HasanPrestoQ
//
//  Created by Hasan D Edain on 3/19/19.
//  Copyright © 2019 NPC Unlimited. All rights reserved.
//

import Foundation
import os.log

protocol PrestoQFetcherDelegate {
    func dataReceived(data: Data)
    func errorReceived(error: Error)
}

class PrestoQFetcher {
    var delegate: PrestoQFetcherDelegate

    init(delegate: PrestoQFetcherDelegate) {
        self.delegate = delegate
    }

    func fetchEndpoint(url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in

            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    os_log("Status: %d", response.statusCode)
                }
            }

            if let data = data, data.count > 0 {
                self.dataReceived(data: data)
            } else if data?.count == 0 {
                //TODO: Create error to report
                os_log("Zero Length Data received")
            } else if let error = error {
                self.errorReceived(error: error)
            }
        }).resume()
    }

    func dataReceived(data: Data) {
        delegate.dataReceived(data: data)
    }

    func errorReceived(error: Error) {
        delegate.errorReceived(error: error)
    }
}
