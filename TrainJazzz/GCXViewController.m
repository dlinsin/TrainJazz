//
//  GCXViewController.m
//  TrainJazzz
//
//  Created by David Linsin on 06/18/13.
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "GCXViewController.h"
#import "GCXStationLoader.h"
#import "AnnotationCoordinateConverter.h"
#import "MKMapView+ZoomLevel.h"

@interface GCXViewController ()

@property(nonatomic, strong) MKMapView *mapView;
@property(nonatomic, strong) GCXStationLoader *loader;

@end

@implementation GCXViewController
{
    NSArray *allStations;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.loader = [[GCXStationLoader alloc] init];
    self.loader.delegate = self;

    self.mapView = [[MKMapView alloc] initWithFrame:CGRectZero];
    CLLocationCoordinate2D startCoordinates;
    startCoordinates.latitude = 50.937531;
    startCoordinates.longitude = 6.960279;
    self.mapView.region = MKCoordinateRegionMakeWithDistance(startCoordinates, 10000, 10000);
    self.mapView.delegate = self;
    [self.mapView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.view addSubview:self.mapView];

    MKMapView *map = self.mapView;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(map);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[map]|" options:(NSLayoutFormatOptions) 0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[map]|" options:(NSLayoutFormatOptions) 0 metrics:nil views:viewsDictionary]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.loader startLoading];
}


#pragma mark -
#pragma mark - GCXStationLoaderDelegate

// will be called frequently with station updates
- (void)stationsLoaded:(NSArray *)stations {
    NSLog(@"Loaded: %@", stations);
    
    allStations = stations;
    // add map annotations
    [self.mapView removeAnnotations:self.mapView.annotations];
    [AnnotationCoordinateConverter mutateCoordinatesOfClashingAnnotations:stations];
    NSLog(@"converted: %@", stations);

    [self.mapView addAnnotations:stations];
    //    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate zoomLevel:10 animated:NO];
}



#pragma mark -
#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // change on zoom
    
    NSUInteger zoomlevel = [mapView zoomLevel];
    
    
    
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    // change on zoom
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    NSLog(@"requesting annotation view");
    // create
    static NSString *AnnotationViewID = @"AnnotationView";
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }

    
    annotationView.image = [UIImage imageNamed:@"discover_map_icon-item-position"];
    annotationView.annotation = annotation;
    annotationView.canShowCallout = YES;
//    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;    
}




@end
