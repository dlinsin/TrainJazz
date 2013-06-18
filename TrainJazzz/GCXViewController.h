//
//  GCXViewController.h
//  TrainJazzz
//
//  Created by David Linsin on 06/18/13.
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GCXStationLoader.h"

@class GCXStationLoader;

@interface GCXViewController : UIViewController <MKMapViewDelegate, GCXStationLoaderDelegate>

@end