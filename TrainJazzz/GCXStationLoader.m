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
@property(nonatomic, strong) NSURLConnection *connection;
@property(nonatomic, strong) NSMutableData *loadedData;
@end

@implementation GCXStationLoader

- (void)startLoading {
    self.loadedData = [NSMutableData data];
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

    if (self.connection) {
        [self.connection cancel];
    }

    NSString *url = [NSString stringWithFormat:@"http://10.197.197.210:9000/test"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:1.0];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.loadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Finished loading");
    // TODO use self.loadedData

    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"sample" ofType:@"json"]]; //self.loadedData;
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

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Failed loading");
    // TODO error handling
    [self connectionDidFinishLoading:connection];
}


@end