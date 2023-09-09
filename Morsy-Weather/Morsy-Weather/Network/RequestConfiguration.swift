//
//  RequestConfiguration.swift
//  Morsy-Weather
//
//  Created by Abdelsalam Morsy on 09.09.23.
//

enum RequestConfiguration {
    case weatherForLocation(lat: Double, lon: Double)
    case searchForLocations(keyword: String, limit: Int)
}

// MARK: - Path
extension RequestConfiguration {
    var path: String {
        switch self {
            case let .weatherForLocation(lat, lon):
                return "data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constant.weatherAPIKey)"

            case let .searchForLocations(keyword, limit):
                return "geo/1.0/direct?q=\(keyword)&limit=\(limit)&appid=\(Constant.weatherAPIKey)"
        }
    }
}

// MARK: - Method
extension RequestConfiguration {
    var method: HTTPMethod {
        switch self {
            case .weatherForLocation,
                    .searchForLocations:
                return .get
        }
    }
}

// MARK: - RequestConfiguration extension
extension RequestConfiguration {
    var baseURL: String {
        return Constant.baseURL
    }

    var parameters: [String: Any]? {
        return nil
    }

    var headers: [String: String]? {
        return nil
    }
}
