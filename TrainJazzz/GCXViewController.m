//
//  GCXViewController.m
//  TrainJazzz
//
//  Created by David Linsin on 06/18/13.
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//

#import "GCXViewController.h"
#import "GCXStationLoader.h"

@interface GCXViewController ()

@property(nonatomic, strong) MKMapView *mapView;
@end

@implementation GCXViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GCXStationLoader *loader = [[GCXStationLoader alloc] init];
    NSArray *stations = [loader loadStations];


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

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // change on zoom
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    // change on zoom
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // dequeueReusableAnnotationViewWithIdentifier:
    // create
    return nil;
}


@end