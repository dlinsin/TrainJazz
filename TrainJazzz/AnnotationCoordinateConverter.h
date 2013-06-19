//
//  AnnotationCoordinateConverter.h
//  TrainJazzz
//
//  Created by Veronica Garcia on 18.06.13.
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AnnotationCoordinateConverter : NSObject

+ (void)mutateCoordinatesOfClashingAnnotations:(NSArray *)annotations;

@end
