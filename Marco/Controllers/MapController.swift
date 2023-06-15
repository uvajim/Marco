import Foundation
import CoreLocation
import MapKit

class GeoCoder {
    let geocoder = CLGeocoder()
    
    func getCoordinates(address: String) async throws -> CLLocationCoordinate2D? {
        let placemarks = try await geocoder.geocodeAddressString(address)
        
        guard let placemark = placemarks.first, let location = placemark.location else {
            throw NSError(domain: "com.yourappname.error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to find location for address"])
        }
        
        return location.coordinate
    }
}

class MapViewModel: ObservableObject {
    @Published var region:MKCoordinateRegion
    @Published var isLoading = false
    
    let geocoder = GeoCoder()
    
    init(latitude: Double, longitude: Double) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        self.region = MKCoordinateRegion(center: center, span: span)
    }
    
    
    func updateCoordinates(latitude: Double, longitude: Double){
        isLoading = true
        Task {
            do {
                    // Ensure UI updates are performed on the main thread
                    DispatchQueue.main.async {
                        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                        self.region = MKCoordinateRegion(center: center, span: span)
                        self.isLoading = false
                    }
            } catch {
                print("Geocoding error: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
    
    func updateRegion(name: String) {
        isLoading = true
        Task {
            do {
                if let coordinates = try await geocoder.getCoordinates(address: name) {
                    // Ensure UI updates are performed on the main thread
                    DispatchQueue.main.async {
                        self.region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                        self.isLoading = false
                    }
                }
            } catch {
                print("Geocoding error: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
}





