//
//  WeatherManager.swift
//  Clima
//
//  Created by Alexey Yarov on 30.04.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=cbcf676aebbe80edbac5de2397f2d4bc&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    func performRequest (urlString: String) {
        // 1.Here we create URLSession
        if let url = URL(string: urlString){
            //2. Here we create a URLSession
            let session = URLSession(configuration: .default)
            //3. Here we give the session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            //4. And here we start a task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
        
    }
    
    
    
}
