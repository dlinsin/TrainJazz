//
//  GCXLine
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface GCXLine : NSObject<MKAnnotation>

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *line;
@property(nonatomic, strong) NSString *latency;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id)initWithJson:(NSDictionary *)json;

- (NSString *)description;

@end