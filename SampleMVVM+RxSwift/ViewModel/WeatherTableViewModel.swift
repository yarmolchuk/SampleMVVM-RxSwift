//
//  WeatherTableViewModel.swift
//  SampleMVVM+RxSwift
//
//  Created by Dima Yarmolchuk on 31.03.16.
//  Copyright © 2016 Dima Yarmolchuk. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftyJSON
import Alamofire

extension NSDate {
    var dayString:String {
        let formatter = NSDateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("d M")
        return formatter.stringFromDate(self)
    }
}

class WeatherTableViewModel {
    
    struct Constants {
        static let baseURL = "http://api.openweathermap.org/data/2.5/forecast?q="
        static let urlExtension = "&units=metric&type=like&APPID=6a700a1e919dc96b0a98901c9f4bec47"
        static let baseImageURL = "http://openweathermap.org/img/w/"
        static let imageExtension = ".png"
    }
    
    var disposeBag = DisposeBag()
    
    //MARK: Model
    
    var weather: Weather? {
        didSet {
            if weather?.cityName != nil {
                updateModel()
            }
        }
    }
    
    //MARK: UI
    
    var cityName = PublishSubject<String?>()
    var degrees = PublishSubject<String?>()
    var weatherDescription = PublishSubject<String?>()
    private var forecast:[WeatherForecast]?
    var weatherImage = PublishSubject<UIImage?>()
    var backgroundImage = PublishSubject<UIImage?>()
    var tableViewData = PublishSubject<[(String, [WeatherForecast])]>()
    var errorAlertController = PublishSubject<UIAlertController>()

    func updateModel() {
        cityName.on(.Next(weather?.cityName))
        if let temp = weather?.currentWeather?.temp {
            degrees.on(.Next(String(temp)))
        }
        weatherDescription.on(.Next(weather?.currentWeather?.description))
        if let id = weather?.currentWeather?.imageID {
//            setWeatherImageForImageID(id)
//            setBackgroundImageForImageID(id)
        }
        forecast = weather?.forecast
        if forecast != nil {
//            sendTableViewData()
        }
    }
}
