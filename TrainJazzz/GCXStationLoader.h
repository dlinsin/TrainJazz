//
//  GCXStationLoader
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import <Foundation/Foundation.h>

@class RNTimer;

@protocol GCXStationLoaderDelegate

- (void)stationsLoaded:(NSArray *)stations;

@end


@interface GCXStationLoader : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic, weak) id<GCXStationLoaderDelegate> delegate;

- (void)startLoading;

@end