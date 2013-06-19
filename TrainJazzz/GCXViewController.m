//
//  GCXViewController.m
//  TrainJazzz
//
//  Created by David Linsin on 06/18/13.
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//

#import "GCXViewController.h"
#import "AnnotationCoordinateConverter.h"
#import "MKMapView+ZoomLevel.h"
#import "GCXCircleAnnotationView.h"
#import "GCXLineColor.h"
#import "GCXLine.h"
#import "GCXStation.h"

@interface GCXViewController ()

@property(nonatomic, strong) MKMapView *mapView;
@property(nonatomic, strong) GCXStationLoader *loader;

@end

@implementation GCXViewController
{
    NSArray *allStations;
    NSArray *clusteredStations;
    NSArray *expandedStations;
    
    NSUInteger currentZoomLevel;
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
    currentZoomLevel = [self.mapView zoomLevel];
//    [self.mapView setCenterCoordinate:startCoordinates zoomLevel:currentZoomLevel animated:NO];
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
//    NSLog(@"Loaded: %@", stations);
    
    // add map annotations
    [self.mapView removeAnnotations:self.mapView.annotations];
    [AnnotationCoordinateConverter mutateCoordinatesOfClashingAnnotations:stations];
    
    clusteredStations = stations.copy;
    NSLog(@"clusteredStations: %@", clusteredStations);
    
    NSMutableArray *stationsAndLines = [[NSMutableArray alloc] init];
    for (GCXStation *station in stations) {
        [stationsAndLines addObject:station];
        for (GCXStation *line in station.lines) {
            [stationsAndLines addObject:line];
        }
    }
    expandedStations = stationsAndLines;
    
    NSLog(@"expandedStations: %@", expandedStations);
    
    [self.mapView addAnnotations:clusteredStations];
//    CLLocationCoordinate2D startCoordinates;
//    
//    startCoordinates.latitude = 50.937531;
//    startCoordinates.longitude = 6.960279;
//    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate zoomLevel:10 animated:NO];
}



#pragma mark -
#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // change on zoom
    
    NSArray *stations = clusteredStations;
    NSUInteger zoomlevel = [mapView zoomLevel];
    
    if (zoomlevel == currentZoomLevel) {
        return;
    }
    
    if (currentZoomLevel < zoomlevel) {
        //zoom in -> expand stations
        stations = expandedStations;
        
    } else {
        //zoom out -> collapse stations
        stations = clusteredStations;
    }
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:stations];
    
    currentZoomLevel = zoomlevel;
    
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    // change on zoom
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    NSLog(@"requesting annotation view: %@", annotation);
    static NSString *AnnotationViewID = @"AnnotationView";
    MKAnnotationView *annotationView;
    if ([annotation isKindOfClass:[GCXStation class]]) {
        annotationView = [[GCXCircleAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID number:[((GCXStation *)annotation).lines count]];
        annotationView.canShowCallout = NO;
    } else {
        GCXLine *line = (GCXLine*)annotation;
        UIColor *color = [[GCXLineColor sharedInstance] colorForLine:line.line];
        BOOL showHalo = [line.latency intValue] >= 2;
        annotationView = [[GCXCircleAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID color:color halo:showHalo];
        annotationView.canShowCallout = YES;
        if (!showHalo) {
            annotationView.calloutOffset = CGPointMake(0.0f, 40.0f);
        } else {
            annotationView.calloutOffset = CGPointMake(0.0f, 25.0f);
        }
    }

    return annotationView;    
}




@end
