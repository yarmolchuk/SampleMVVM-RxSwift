//
//  Weather.swift
//  SampleMVVM+RxSwift
//
//  Created by Dima Yarmolchuk on 30.03.16.
//  Copyright © 2016 Dima Yarmolchuk. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias JSONDictionary = [String: AnyObject]
typealias WeatherForecast = (date: NSDate, imageID: String?, temp: Double?, description: String?)

class Weather {

    struct Constants {
        static let baseURL = "http://api.openweathermap.org/data/2.5/forecast?q="
        static let urlParams = "&units=imperial&type=like&APPID=6a700a1e919dc96b0a98901c9f4bec47"
        static let baseImageURL = "http://openweathermap.org/img/w/"
        static let imageExtension = ".png"
    }
    
    var cityName:String?
    var forecast = [WeatherForecast]()
    
    var currentWeather:WeatherForecast? {
        if !forecast.isEmpty {
            return forecast[0]
        } else {
            return nil
        }
    }
    
    init(jsonObject: AnyObject) {
        let json = JSON(jsonObject)
        
        self.cityName = json["city"]["name"].stringValue
        if let forecastArray = json["list"].array {
            for item in forecastArray {
                let itemForecast = (date: NSDate(timeIntervalSince1970: NSTimeInterval(item["dt"].intValue)),
                                    imageID: item["weather"][0]["icon"].string,
                                    temp: item["main"]["temp"].double,
                                    description: item["weather"][0]["description"].string)
                
                forecast.append(itemForecast)
            }
        }
    }
}
