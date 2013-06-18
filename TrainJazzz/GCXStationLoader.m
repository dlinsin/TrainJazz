//
//  GCXStationLoader
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import "GCXStationLoader.h"
#import "GCXStation.h"
#import "RNTimer.h"


@interface GCXStationLoader ()
@property(nonatomic, strong) RNTimer *timer;
@end

@implementation GCXStationLoader

- (void)startLoading {
    if (!self.timer) {
        [self doLoad];
    } else {
        [self.timer invalidate];
    }
    __weak id weakSelf = self;
    self.timer = [RNTimer repeatingTimerWithTimeInterval:30
                                                   block:^{
                                                       [weakSelf doLoad];
                                                   }];


}

- (void)doLoad {
    NSLog(@"Do Load called");
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"sample" ofType:@"json"]];
    NSError *error;
    NSArray *stationJSONArray = [(NSDictionary *) [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingOptions) 0 error:&error] objectForKey:@"stations"];

    if (error) {
        NSLog(@"Failed parsing");
    }

    NSMutableArray *stations = [NSMutableArray array];

    for (NSDictionary *stationDict in stationJSONArray) {
        [stations addObject:[[GCXStation alloc] initWithJson:stationDict]];
    }

    [self.delegate stationsLoaded:stations];
}

@end