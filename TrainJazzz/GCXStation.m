//
//  GCXStation
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import "GCXStation.h"


@implementation GCXStation

- (id)initWithJson:(NSDictionary *)json {
    self = [super init];
    if (self) {
        NSString *key;
        for (key in json) {
            @try {
                [self setValue:[json objectForKey:key] forKey:key];
            } @catch (NSException *e) {
                NSLog(@"main: Caught %@: %@", [e name], [e reason]);
            }
        }

        CLLocationCoordinate2D tmp;
        tmp.latitude = [(NSNumber*)[self.location objectAtIndex:0] doubleValue];
        tmp.longitude = [(NSNumber*)[self.location objectAtIndex:1] doubleValue];
        _coordinate = tmp;
    }

    return self;
}

@end