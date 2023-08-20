//
//  SearchView.swift
//  Project02
//
//  Created by Muneera Y on 02/02/1445 AH.
//

import SwiftUI

struct SearchView: View {
    @StateObject var weatherModel = WeatherViewModel()
    let cities = ["New York", "Los Angeles", "London", "Paris", "Tokyo"]
    var body: some View {
        ZStack{
            VStack{
                
                
                List {
                   
                        //                        NavigationLink(destination: {
                        //                            weatherModel.cityName = cities[index]
                        //                            ContentView()
                        //
                        //
                        //                        }, label: {
                        //                            Text(cities[index])
                        //                        })
                        
                    }
                    
                }
                
            }
//        }.background(Color(hue: 0.655, saturation: 0.787, brightness: 0.354))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
