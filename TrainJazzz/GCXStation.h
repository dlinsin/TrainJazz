//
//  GCXStation
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GCXStation : NSObject<MKAnnotation>

@property(nonatomic, strong) NSNumber *identifier;
@property(nonatomic, strong) NSDictionary *location;
@property(nonatomic, strong) NSArray *lines;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithJson:(NSDictionary *)json;

- (NSString *)description;

@end