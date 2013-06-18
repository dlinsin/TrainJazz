//
//  GCXLine
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface GCXLine : NSObject

@property(nonatomic, strong) NSString *line;
@property(nonatomic, strong) NSString *latency;

- (id)initWithJson:(NSDictionary *)json;

- (NSString *)description;
@end