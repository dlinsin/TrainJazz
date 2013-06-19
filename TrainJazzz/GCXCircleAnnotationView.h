//
//  GCXCircleAnnotationView
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface GCXCircleAnnotationView : MKAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier color:(UIColor *)color halo:(BOOL)showHalo;

@end