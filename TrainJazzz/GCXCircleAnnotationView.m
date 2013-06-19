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
@property(nonatomic) NSInteger number;
@property(nonatomic) NSString *mins;
@end

@implementation GCXCircleAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier color:(UIColor *)color halo:(BOOL)showHalo number:(NSInteger)number mins:(NSString*)mins {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect myFrame = self.frame;
        myFrame.size.width = 100;
        myFrame.size.height = 100;
        self.frame = myFrame;
        self.opaque = NO;

        _color = color;
        _halo = showHalo;
        _number = number;
        _mins = mins;
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
        _number = -1;
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

    if (self.number > 0) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tooltip.png"]];
        view.tag = 12;
        view.hidden = YES;
        view.frame = CGRectIntegral(CGRectMake(55.0, 35.0, 95.0, 30.0));

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(5.0, 5.0, 95.0, 20.0))];
        label.font = [UIFont boldSystemFontOfSize:14.0f];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"in  %@ min", self.mins];

        [view addSubview:label];

        [self addSubview:view];
    }

    UIBezierPath *innerPath = [UIBezierPath bezierPath];
    [innerPath addArcWithCenter:CGPointMake(50.0, 50.0)
                         radius:20.0f
                     startAngle:0.0
                       endAngle:M_PI * 2.0
                      clockwise:YES];

    CAShapeLayer *innerShape = [CAShapeLayer layer];
    innerShape.path = [innerPath CGPath];
    innerShape.strokeColor = [[UIColor whiteColor] CGColor];
    innerShape.fillColor = [self.color CGColor];
    innerShape.lineWidth = 2.0;

    [self.layer addSublayer:innerShape];

    if (self.number > 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(40.0, 40.0, 20.0, 20.0))];
        label.font = [UIFont boldSystemFontOfSize:16.0f];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%d", self.number];
        [self addSubview:label];
    }

}

@end