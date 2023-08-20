
import SwiftUI


enum UnitType: String , CaseIterable{
    case metric = "°C"
    case imperial = "°F"
}
enum WindSpeedUnit: String, CaseIterable {
    case defaultUnit = "meter/sec"
    case imperial = "miles/hour"
 
}
enum AppError: Error {
    case networkError
    case invalidCityName
    case apiError(String)
}
