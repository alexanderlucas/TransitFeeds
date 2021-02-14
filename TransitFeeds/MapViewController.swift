//
//  ViewController.swift
//  TransitFeeds
//
//  Created by Alex Lucas on 2/13/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var feeds: [Feed]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        mapView.delegate = self

        WebService.shared.loadFeeds { (result) in
            switch result {
            case .success(let feeds):
                self.feeds = feeds
            case .failure(let error):
                print("error: \(error)")
            }
            DispatchQueue.main.async {
                self.addAnnotations()
            }
        }

    }

    func addAnnotations() {
        guard let feeds = feeds else { return }

        for feed in feeds {
            let annotation = FeedAnnotation(coordinate: feed.bounds.midpoint, feed: feed)
            mapView.addAnnotation(annotation)
        }
    }


}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let feedAnnotation = annotation as? FeedAnnotation else {
            return nil
        }

        let identifier = "feed"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = feedAnnotation
            view = dequeuedView
        } else {

            view = MKMarkerAnnotationView(
                annotation: feedAnnotation,
                reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: 0, y: 10)
            view.rightCalloutAccessoryView = UIView() // otherwise the callout is just text on a map

        }
        view.glyphImage = UIImage(named: "pin")

        switch feedAnnotation.feed.countryCode {
        case "CA":
            view.markerTintColor = .canada
        case "US":
            view.markerTintColor = .unitedStates
        case "FR":
            view.markerTintColor = .france
        case "GB", "UK":
            view.markerTintColor = .unitedKingdom
        case "DE":
            view.markerTintColor = .germany
        default:
            view.markerTintColor = .otherCountry

        }

        return view


    }
}
