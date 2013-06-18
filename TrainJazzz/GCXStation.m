//
//  GCXStation
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import "GCXStation.h"
#import "GCXLine.h"


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

        NSMutableArray *tmpLines = [NSMutableArray array];
        for (NSDictionary *lineDict in _lines) {
            GCXLine *line = [[GCXLine alloc] initWithJson:lineDict];
            [tmpLines addObject:line];
        }
        _lines = [NSArray arrayWithArray:tmpLines];

        CLLocationCoordinate2D tmp;
        tmp.latitude = [[self.location objectForKey:@"latitude"] doubleValue];
        tmp.longitude = [[self.location objectForKey:@"latitude"] doubleValue];
        _coordinate = tmp;
    }

    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"coordinate.latitude=%f", coordinate.latitude];
    [description appendFormat:@", coordinate.longitude=%f", coordinate.longitude];
    [description appendFormat:@", self.identifier=%@", self.identifier];
    [description appendFormat:@", self.location=%@", self.location];
    [description appendFormat:@", self.lines=%@", self.lines];
    [description appendFormat:@", self.coordinate.latitude=%f", self.coordinate.latitude];
    [description appendFormat:@", self.coordinate.longitude=%f", self.coordinate.longitude];
    [description appendString:@">"];
    return description;
}


@end