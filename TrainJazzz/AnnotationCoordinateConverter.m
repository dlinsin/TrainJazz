//
//  AnnotationCoordinateConverter.m
//  TrainJazzz
//
//  Created by Veronica Garcia on 18.06.13.
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import "AnnotationCoordinateConverter.h"
#import "GCXStation.h"
#import "GCXLine.h"

#define kEarthRadius     6378100

@implementation AnnotationCoordinateConverter

+ (void)mutateCoordinatesOfClashingAnnotations:(NSArray *)annotations {
    
    NSDictionary *coordinateValuesToAnnotations = [self groupAnnotationsByLocationValue:annotations];
    
    for (NSValue *coordinateValue in coordinateValuesToAnnotations.allKeys) {
        NSMutableArray *outletsAtLocation = coordinateValuesToAnnotations[coordinateValue];
        CLLocationCoordinate2D coordinate;
        [coordinateValue getValue:&coordinate];
        [self repositionAnnotations:outletsAtLocation toAvoidClashAtCoordination:coordinate];
    }
}

+ (NSDictionary *)groupAnnotationsByLocationValue:(NSArray *)annotations {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    

    for (id<MKAnnotation> annotation in annotations) {
    
        CLLocationCoordinate2D coordinate = annotation.coordinate;
        NSValue *coordinateValue = [NSValue valueWithBytes:&coordinate objCType:@encode(CLLocationCoordinate2D)];
        
        NSMutableArray *annotationsAtLocation = result[coordinateValue];
        if (!annotationsAtLocation) {
            annotationsAtLocation = [NSMutableArray array];
            result[coordinateValue] = annotationsAtLocation;
        }
        
        [annotationsAtLocation addObject:annotation];
    }
    return result;
}

+ (void)repositionAnnotations:(NSMutableArray *)annotations toAvoidClashAtCoordination:(CLLocationCoordinate2D)coordinate {
    
    for (GCXStation *station in annotations) {
        NSMutableArray *lines = station.lines.mutableCopy;
        
        double distance = 300 * lines.count / 2.0;
        double radiansBetweenAnnotations = (M_PI * 2) / lines.count;
        
        for (int i = 0; i < lines.count; i++) {
            
            double heading = radiansBetweenAnnotations * i;
            CLLocationCoordinate2D newCoordinate = [self calculateCoordinateFrom:coordinate onBearing:heading atDistance:distance];
            
            id <MKAnnotation> annotation = lines[i];
            annotation.coordinate = newCoordinate;
        }
    }
}

+ (CLLocationCoordinate2D)calculateCoordinateFrom:(CLLocationCoordinate2D)coordinate  onBearing:(double)bearingInRadians atDistance:(double)distanceInMetres {
    
    double coordinateLatitudeInRadians = coordinate.latitude * M_PI / 180;
    double coordinateLongitudeInRadians = coordinate.longitude * M_PI / 180;
    
    double distanceComparedToEarth = distanceInMetres / kEarthRadius;
    
    double resultLatitudeInRadians = asin(sin(coordinateLatitudeInRadians) * cos(distanceComparedToEarth) + cos(coordinateLatitudeInRadians) * sin(distanceComparedToEarth) * cos(bearingInRadians));
    double resultLongitudeInRadians = coordinateLongitudeInRadians + atan2(sin(bearingInRadians) * sin(distanceComparedToEarth) * cos(coordinateLatitudeInRadians), cos(distanceComparedToEarth) - sin(coordinateLatitudeInRadians) * sin(resultLatitudeInRadians));
    
    CLLocationCoordinate2D result;
    result.latitude = resultLatitudeInRadians * 180 / M_PI;
    result.longitude = resultLongitudeInRadians * 180 / M_PI;
    return result;
}

@end
