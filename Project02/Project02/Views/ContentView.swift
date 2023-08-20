

import SwiftUI
import _CoreLocationUI_SwiftUI


struct ContentView: View {
    
    //    @State private var weatherData : Weather?
    
    let session: URLSession = .shared
    //    @State var cityName: String = ""
    @StateObject var weatherModel = WeatherViewModel()
    @StateObject var locationManager = LocationManager()
    @State private var isTextFieldVisible = false
    let cities = ["Riyadh", "Angeles", "London", "Paris", "Tokyo"]
   
    let gridItem =
    [GridItem()]
    var body: some View {
        NavigationStack{
            
            TabView {
                GeometryReader {geometry in
                    ZStack{
                        VStack{
                            
                            
                            ScrollView{
                                if isTextFieldVisible {
                                    HStack {
                                        TextField(" Enter your city name", text: $weatherModel.cityName)
                                        
                                            .frame(width: .infinity, height: 50)
                                           
                                            
                                            .foregroundColor(Color(red: 0.074, green: 0.092, blue: 0.355))
                                         
                                        Picker("city", selection: $weatherModel.cityName){
                                            ForEach(0..<cities.count, id: \.self) { index in
                                                Text(cities[index]).tag(cities[index])
                                                         }


                                        }.pickerStyle(.menu)
                                            
                                      
                                           
                                        
                                       
                                        
                                    }
                                    .frame(height: 50)
                                    .background(Color.white)
                                    .border(Color.gray, width: 2)
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                                 
                                }
                                Text(weatherModel.weatherDatatemp.first?.name ?? "Riyadh")
                                
                                    .font(.largeTitle)
                                
                                    .frame(maxWidth: .infinity)
                                Picker("Unit", selection: $weatherModel.selectedUnit) {
                                    Text("Metric").tag(UnitType.metric)
                                    Text("Imperial").tag(UnitType.imperial)
                                }.pickerStyle(SegmentedPickerStyle())
                                
                                    .background(.white)
                                    .frame(width: 300, height: 50).cornerRadius(20)
                                
                                
                                ForEach(weatherModel.weatherDatatemp, id: \.name) { weather in
                                    //
                                    //
                                    WeatherImageView(icon: weather.weather[0].icon)
                                    
                                    Text("\(weatherModel.formatTemperature(weatherModel.convertedTemperature))  \(weatherModel.selectedUnit.rawValue)") .font(.title).fontWeight(.medium)
                                    
                                    
                                    Text("\(weather.weather[0].main) - Feels like \(weatherModel.formatTemperature(weatherModel.convertedTemperatureaFeelsLike))")
                                    
                                    Spacer()
                                        .padding()
                                    
                                    VStack{
                                        
                                        HStack{
                                            
                                            Image(systemName: "humidity.fill")
                                                .renderingMode(.original)
                                                .imageScale(.large)
                                            
                                            Text("\(weather.main.humidity) % ")
                                            
                                        }.frame(width: 350, alignment: .leading)
                                        .font(.system(size: 40))
                                        
                                        
                                        HStack{
                                            Image(systemName: "wind")             .renderingMode(.original)
                                                .imageScale(.large)
                                            
                                            //                                    Text("Wind Speed")
                                            Text(" \(weatherModel.formatSpeed(weatherModel.convertToMilesPerHour))")
                                                
                                            Text("\(weatherModel.windSpeedUnit.rawValue)").font(.system(size: 15))
                                            //   .convertToMilesPerHour(weatherModel.weatherDatatemp.first?.wind.speed                                 .font(.caption)
                                                .fontWeight(.medium)
                                            
                                            
                                            
                                        }.frame(width: 350, alignment: .leading).font(.system(size: 40))
                                        
                                        HStack{
                                            Image(systemName: "sunrise")       .renderingMode(.original)
                                                .imageScale(.large)
                                            //                                    Text("Wind Speed")
                                            Text("\(weatherModel.formatUnixTimestamp(TimeInterval(weather.sys.sunrise)))")
                                            //                                    .font(.caption)
                                                .fontWeight(.medium)
                                            
                                            
                                            
                                        }.frame(width: 350, alignment: .leading)
                                        .font(.system(size: 40))
                                        HStack{
                                            Image(systemName: "sunset")       .renderingMode(.original)
                                                .imageScale(.large)
                                            //                                    Text("Wind Speed")
                                            Text("\(weatherModel.formatUnixTimestamp(TimeInterval(weather.sys.sunset)))")
                                            //                                    .font(.caption)
                                                .fontWeight(.medium)
                                            
                                            
                                            
                                        }.frame(width: 350, alignment: .leading)
                                        .font(.system(size: 40))
                                    }.padding(.horizontal)
                                }
                                
                                
                                
                                
                                if let location = locationManager.location {
                                    Text("Your location: \(location.latitude), \(location.longitude)")
                                }
//                                
//                                LocationButton {
//                                    locationManager.requestLocation()
//                                }
//                                .frame(height: 44)
//                                .padding()
                              
                                
                                //
                                //                        ForEach(weatherModel.weatherDatatemp, id: \.name) { weather in
                                //                            Text("Main: \(weather.name)")
                                //
                                //
                                //                            Text(weather.main.temp.description)
                                //
                                //
                                //
                            }
                            //
                            //
                            //
                            //
                            
                            //            }
                            
                            .onChange(of: weatherModel.cityName) {
                                newVlue in
                                
                                weatherModel.fetchWeatherdata(newVlue)
                                
                            }
                            .onAppear(){
                                weatherModel.fetchWeatherdata(weatherModel.cityName)
                            }
                            
                            
                            .foregroundColor(.white)
                            
       
                            
                        }
                        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                        .frame(width: geometry.size.width, height: geometry.size.height )
                       
                    }
                    .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                    .toolbar{
                        
                        ToolbarItemGroup(placement: .navigationBarLeading) {           Button(action: {

                            isTextFieldVisible.toggle()
                        }, label: {

                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(red: 0.608, green: 0.563, blue: 0.542))
                            .bold()})

                     

                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                      
                            Picker("Select Unit", selection: $weatherModel.windSpeedUnit) {
                                ForEach(WindSpeedUnit.allCases, id: \.self) { unit in
                                    Text(unit.rawValue)
                                      
                                }
                            } .pickerStyle(.menu)
                            .foregroundColor(.gray)
                                
                               
                        }
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        
        ContentView()
    }
}




