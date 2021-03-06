//
//  GCXLine
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import "GCXLine.h"


@implementation GCXLine

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
        _title = [NSString stringWithFormat:@"%@ - %@ min", _line, _latency];
    }

    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.line=%@", self.line];
    [description appendFormat:@", self.latency=%@", self.latency];
    [description appendFormat:@", self.coordinate.latitude=%f", self.coordinate.latitude];
    [description appendFormat:@", self.coordinate.longitude=%f", self.coordinate.longitude];
    [description appendString:@">"];
    return description;
}


@end