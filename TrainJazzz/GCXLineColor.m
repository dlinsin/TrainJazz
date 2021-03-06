//
//  GCXLineColor
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import "GCXLineColor.h"


@implementation GCXLineColor

+ (instancetype)sharedInstance {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        NSMutableDictionary *lines = [NSMutableDictionary dictionary];
        [lines setObject:[UIColor colorWithRed:0.0f/255.0f green:159.0f/255.0f blue:170.0f/255.0f alpha:1.0f] forKey:@"16"];
        [lines setObject:[UIColor colorWithRed:43.0f/255.0f green:156.0f/255.0f blue:243.0f/255.0f alpha:1.0f] forKey:@"18"];
        [lines setObject:[UIColor colorWithRed:127.0f/255.0f green:191.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forKey:@"17"];
        [lines setObject:[UIColor colorWithRed:255.0f/255.0f green:31.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forKey:@"1"];
        [lines setObject:[UIColor colorWithRed:255.0f/255.0f green:159.0f/255.0f blue:85.0f/255.0f alpha:1.0f] forKey:@"7"];
        [lines setObject:[UIColor colorWithRed:255.0f/255.0f green:159.0f/255.0f blue:170.0f/255.0f alpha:1.0f] forKey:@"3"];
        [lines setObject:[UIColor colorWithRed:255.0f/255.0f green:127.0f/255.0f blue:170.0f/255.0f alpha:1.0f] forKey:@"4"];
        [lines setObject:[UIColor colorWithRed:222.0f/255.0f green:131.0f/255.0f blue:142.0f/255.0f alpha:1.0f] forKey:@"9"];
        [lines setObject:[UIColor colorWithRed:85.0f/255.0f green:191.0f/255.0f blue:85.0f/255.0f alpha:1.0f] forKey:@"15"];
        [lines setObject:[UIColor colorWithRed:127.0f/255.0f green:191.0f/255.0f blue:85.0f/255.0f alpha:1.0f] forKey:@"12"];
        [lines setObject:[UIColor colorWithRed:170.0f/255.0f green:223.0f/255.0f blue:85.0f/255.0f alpha:1.0f] forKey:@"6"];
        [lines setObject:[UIColor colorWithRed:170.0f/255.0f green:159.0f/255.0f blue:170.0f/255.0f alpha:1.0f] forKey:@"5"];
        [lines setObject:[UIColor colorWithRed:170.0f/255.0f green:134.0f/255.0f blue:103.0f/255.0f alpha:1.0f] forKey:@"13"];
        [sharedInstance setLineColors:lines];
    });
    return sharedInstance;
}

- (UIColor *)colorForLine:(NSString *)line {
    return [self.lineColors objectForKey:line];
}

@end