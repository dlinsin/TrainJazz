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

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSNumber *identifier;
@property(nonatomic, strong) NSDictionary *location;
@property(nonatomic, strong) NSArray *lines;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id)initWithJson:(NSDictionary *)json;

- (NSString *)description;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToStation:(GCXStation *)station;

- (NSUInteger)hash;

@end