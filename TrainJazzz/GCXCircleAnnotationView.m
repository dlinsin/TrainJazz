//
//  GCXCircleAnnotationView
//  TrainJazzz
//
//  Created by David Linsin on 6/18/13
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//


#import "GCXCircleAnnotationView.h"
#import <QuartzCore/QuartzCore.h>


@interface GCXCircleAnnotationView ()
@property(nonatomic, strong) UIColor *color;
@property(nonatomic) BOOL halo;
@end

@implementation GCXCircleAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier color:(UIColor *)color halo:(BOOL)showHalo {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect myFrame = self.frame;
        myFrame.size.width = 100;
        myFrame.size.height = 100;
        self.frame = myFrame;
        self.opaque = NO;
        
        _color = color;
        _halo = showHalo;
    }

    return self;
}

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect myFrame = self.frame;
        myFrame.size.width = 100;
        myFrame.size.height = 100;
        self.frame = myFrame;
        self.opaque = NO;

        _color = [UIColor blackColor];
        _halo = NO;
    }

    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    if (self.halo) {
        UIBezierPath *outerPath = [UIBezierPath bezierPath];
        [outerPath addArcWithCenter:CGPointMake(50.0, 50.0)
                             radius:50.0f
                         startAngle:0.0
                           endAngle:M_PI * 2.0
                          clockwise:YES];

        CAShapeLayer *outerShape = [CAShapeLayer layer];
        outerShape.path = [outerPath CGPath];
        outerShape.strokeColor = NULL;
        outerShape.fillColor = [self.color CGColor];
        outerShape.lineWidth = 3.0;
        outerShape.opacity = 0.5f;

        [self.layer addSublayer:outerShape];
    }

    UIBezierPath *innerPath = [UIBezierPath bezierPath];
    [innerPath addArcWithCenter:CGPointMake(50.0, 50.0)
                         radius:10.0f
                     startAngle:0.0
                       endAngle:M_PI * 2.0
                      clockwise:YES];

    CAShapeLayer *innerShape = [CAShapeLayer layer];
    innerShape.path = [innerPath CGPath];
    innerShape.strokeColor = [[UIColor whiteColor] CGColor];
    innerShape.fillColor = [self.color CGColor];
    innerShape.lineWidth = 1.0;

    [self.layer addSublayer:innerShape];


}

@end