import Foundation

extension Array {

    static var countries: [Country]? {
        return try? JSONDecoder().decode([Country].self, from: Data(countriesJSON.utf8))
    }
}
