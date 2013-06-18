//
//  GCXStationLoader
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import "GCXStationLoader.h"
#import "GCXStation.h"


@implementation GCXStationLoader

- (NSArray *)loadStations {
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"sample" ofType:@"json"]];
    NSError *error;
    NSArray *stationJSONArray = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingOptions) 0 error:&error];

    if (error) {
        NSLog(@"Failed parsing");
    }

    NSMutableArray *stations = [NSMutableArray array];

    for (NSDictionary *stationDict in stationJSONArray) {
        [stations addObject:[[GCXStation alloc] initWithJson:stationDict]];
    }

    return stations;
}

@end