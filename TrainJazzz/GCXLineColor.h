//
//  GCXLineColor
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface GCXLineColor : NSObject

@property(nonatomic, strong) NSDictionary *lineColors;

+ (instancetype)sharedInstance;
- (UIColor *)colorForLine:(NSString *)line;

@end