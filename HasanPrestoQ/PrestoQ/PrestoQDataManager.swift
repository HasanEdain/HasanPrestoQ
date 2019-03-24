//
//  PrestoQDataManager.swift
//  HasanPrestoQ
//
//  Created by Hasan D Edain on 3/19/19.
//  Copyright © 2019 NPC Unlimited. All rights reserved.
//

import Foundation
import os.log

protocol DataManagerDelegate {
    func managersSpecialsDataReceived(specials: ManagersSpecials)
    func fetchFailed()
}

class PrestoQDataManager: PrestoQFetcherDelegate {
    let managersSpecialsEndpointString = "https://prestoq.com/ios-coding-challenge"
    var managersSpecials: ManagersSpecials?
    private var fetcher: PrestoQFetcher?
    var dataManagerDelegate: DataManagerDelegate?

    init() {
        let fetcher = PrestoQFetcher(delegate: self)
        self.fetcher = fetcher
    }

    func start() {
        if let url = managerSpecialURL(endpoint: managersSpecialsEndpointString) {
            guard let fetcher = self.fetcher else {
                os_log("Failed to create url from string: %@", managersSpecialsEndpointString)
                return
            }
            fetcher.fetchEndpoint(url: url);
        }
    }

    func managerSpecialURL(endpoint: String) -> URL? {
        //TODO: This method may be extranious, or I may want to do some error handling here
        let url = URL(string: endpoint)

        return url
    }

    //MARK: - PrestoQFetcherDelegate
    func dataReceived(data: Data) {
        do {
            let decoder = JSONDecoder()
            let tempManagerSpecials = try decoder.decode(ManagersSpecials.self, from: data)
            DispatchQueue.main.async {
                //TODO: Consider caching these values so that the user can see them imediately upon launch
                self.managersSpecials = tempManagerSpecials
                if let delegate = self.dataManagerDelegate {
                    self.managersSpecials = tempManagerSpecials
                    delegate.managersSpecialsDataReceived(specials: tempManagerSpecials)
                } else {
                    os_log("nil data manager delegate")
                }
            }
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            if let delegate = self.dataManagerDelegate {
                delegate.fetchFailed()
            }
        } catch let DecodingError.keyNotFound(key, context) {
            let errorString = "Key: \(key) Context: \(context)"
            os_log("Decoding Error: %@", errorString)
            if let delegate = self.dataManagerDelegate {
                delegate.fetchFailed()
            }
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            if let delegate = self.dataManagerDelegate {
                delegate.fetchFailed()
            }
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            if let delegate = self.dataManagerDelegate {
                delegate.fetchFailed()
            }
        } catch {
            os_log("Failed to decode data to ManagersSpecials: %@", error.localizedDescription)
            if let delegate = self.dataManagerDelegate {
                delegate.fetchFailed()
            }
        }
    }

    func errorReceived(error: Error) {
        os_log("Error fetching Managers specials: %@", error.localizedDescription)
        if let delegate = self.dataManagerDelegate {
            DispatchQueue.main.async {
                delegate.fetchFailed()
            }
        }
    }


}
