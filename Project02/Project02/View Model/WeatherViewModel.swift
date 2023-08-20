//
//  WeatherViewModel.swift
//  Project02
//
//  Created by Muneera Y on 03/02/1445 AH.
//

import Foundation
import SwiftUI
class WeatherViewModel: ObservableObject{
    @AppStorage("w") var selectedUnit: UnitType = .metric
    var errors: AppError = .networkError
//    @Published var windSpeedUnit: WindSpeedUnit = .defaultUnit
    @AppStorage("windSpeedUnit") var windSpeedUnit: WindSpeedUnit = .defaultUnit
    @AppStorage("temp")  var temperature: Double = 0.0
    @AppStorage ("Data") var weatherDatatemp: [Weather] =  []
    @AppStorage ("City name") var cityName: String = "Riyadh"
 
//    var assign: Weather
    let session: URLSession = .shared
    
//    var weathertt: Weather {
//          return
//      }
    var convertedTemperature: Double {
        if selectedUnit == .metric{
           
            return ((weatherDatatemp.first?.main.temp ?? 0.0  ) - 273.15// Kelivn (K) to Celsius
)} else {
            return weatherDatatemp.first?.main.temp ?? 0.0 // Celsius
        }
    
    }
    var convertedTemperatureaFeelsLike: Double {
        if selectedUnit == .metric {
           
            return ((weatherDatatemp.first?.main.feelsLike ?? 0.0  ) - 273.15// Kelivn (K) to Celsius
)} else {
            return weatherDatatemp.first?.main.feelsLike ?? 0.0 // Celsius
        }
    
    }
    
    var convertToMilesPerHour: Double {
        if windSpeedUnit == .defaultUnit {
            return (weatherDatatemp.first?.wind.speed ?? 00) * 2.23694 // 1 m/s = 2.23694 mph
        } else {
            return weatherDatatemp.first?.wind.speed ?? 00
        }
    }
    
    
    func addCity (_ city : Weather){
 
            print(city)
        weatherDatatemp.append(city)
    }
    
    func fetchWeatherdata(_ cityName: String){


            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=")else{
                return errors = .apiError("not Fond City")
                
            }
        
        var requst = URLRequest(url: url)
        requst.httpMethod = "GET"
        requst.setValue("4f542b60fde47197ddd676187052133f", forHTTPHeaderField: "x-api-key")
      
        let task = session.dataTask(with: requst) {(data, response, error)
            in
            if let error = error{
          
                print("error")
                return
            }
            if let data = data{
                if let  content = String(bytes: data, encoding: .utf8){
                    print(content)
                    do {
                      
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode( Weather.self, from: data)
                        
                        self.weatherDatatemp = [decodedData]
                        print(self.weatherDatatemp)
                    } catch {
                        print(error)
                    }
                    
                }
            }
            
            
        }
        task.resume()
        
        
    }
    func formatUnixTimestamp(_ timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss" // Customize the format as needed
        return dateFormatter.string(from: date)
    }
    
    func formatTemperature(_ temperature: Double) -> String {
        return String(format: "%.0f", temperature)
    }
    func formatSpeed(_ temperature: Double) -> String {
        return String(format: "%.2f", temperature)
    }
}
    









extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8) else {
            return nil
        }
        do {
            let result = try JSONDecoder().decode([Element].self, from: data)
            print("Init from result: \(result)")
            self = result
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        print("Returning \(result)")
        return result
    }
}

