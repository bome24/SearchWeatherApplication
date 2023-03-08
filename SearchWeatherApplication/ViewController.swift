//
//  ViewController.swift
//  SearchWeatherApplication
//
//  Created by BoMin on 2023/03/08.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var citySearchTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.citySearchTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.citySearchTextField.text }
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
        
    }
    
    private func displayWeather(_ weather: Weather?) {
        
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp) ℃"
            self.feelsLikeLabel.text = "Feels like \(weather.feelsLike) ℃"
            self.humidityLabel.text = "\(weather.humidity) 💦"
            
        } else {
            self.temperatureLabel.text = "🙀"
            self.feelsLikeLabel.text = ""
            self.humidityLabel.text = ""
        }
        
    }
    
    private func fetchWeather(by city: String) {
        
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else {
            return
        }
        
        let resource = Resource<WeatherResult>(url: url)
        
        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catchAndReturn(WeatherResult.empty)
            
        search.map { "\($0.main.temp) ℃"}
            .bind(to: self.temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map { "\($0.main.feelsLike) ℃"}
            .bind(to: self.feelsLikeLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity) 💦"}
            .bind(to: self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
        
    }


}


