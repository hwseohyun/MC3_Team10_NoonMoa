import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherTestView: View {
    @ObservedObject var weatherKitManager = WeatherKitManager()
    @StateObject var locationManager = LocationManager()

    var body: some View {

        if locationManager.authorisationStatus == .authorizedWhenInUse {
            VStack {
                Label(weatherKitManager.symbol, systemImage: weatherKitManager.symbol)
                Text(weatherKitManager.temp)
            }
            .padding()
            .task {
                await
                weatherKitManager.getWeather(latitude: locationManager.latitude, longitude: locationManager.longitude)
            }
        } else {
            //사용자가 위치 허용하지 않았을 때
            Text("Error loading location")
        }
    }
}

struct WeatherTestView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherTestView()
    }
}


//import SwiftUI
//import CoreLocation
//import WeatherKit
//
//
//struct WeatherTestView: View {
//    static let location =
//    CLLocation(
//        latitude: .init(floatLiteral: 37.566536),
//        longitude: .init(floatLiteral: 126.977966)
//    )
//
//    @State var weather: Weather?
//
//    func getWeather() async {
//        do {
//            weather = try await Task
//            {
//                try await WeatherService.shared.weather(for: Self.location)
//            }.value
//        } catch {
//            fatalError("\(error)")
//        }
//    }
//
//    var body: some View {
//        if let weather = weather {
//            VStack {
//                Text("Korea")
//                    .font(.largeTitle)
//                    .padding()
//                    .foregroundColor(.blue)
//                Text(weather.currentWeather.temperature.description)
//                    .font(.system(size: 60))
//                Text(weather.currentWeather.condition.description)
//                    .font(.title)
//                Image(systemName: weather.currentWeather.symbolName)
//                    .font(.title)
//            }
//        } else {
//                ProgressView()
//                    .task {
//                        await getWeather()
//                    }
//            }
//        }
//    }
