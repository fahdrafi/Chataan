//
//  CTChartView.m
//  Chataan
//
//  Created by Fahd Rafi on 12/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTChartView.h"

@implementation CTChartView

- (void)setValues:(NSArray *)values {
    _values = values;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    if (self.values.count < 2) return;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSArray* simpleLinearGradientColors = [NSArray arrayWithObjects:
                                           (id)[UIColor colorWithRed:0.7 green:0.7 blue:1.0 alpha:1.0].CGColor,
                                           (id)[UIColor colorWithRed:0.7 green:0.7 blue:1.0 alpha:0.3].CGColor, nil];
    CGFloat simpleLinearGradientLocations[] = {0, 1};
    CGGradientRef simpleLinearGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)simpleLinearGradientColors, simpleLinearGradientLocations);
    
    CGRect frame = self.frame;
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];

    int count = self.values.count;
    CGFloat xDelta = frame.size.width / (count - 1);
    CGFloat height = frame.size.height;
    
    [aPath moveToPoint:CGPointMake(0.0, height - 0.0)];
    [aPath addLineToPoint:CGPointMake(0.0, height - ([(NSNumber*)self.values[0] floatValue])*height)];

    for (int i=1; i<count; i++) {
        [aPath addLineToPoint:CGPointMake(i*xDelta,
                                          height - ([(NSNumber*)self.values[i] floatValue])*height)
        ];
    }
    
    [aPath addLineToPoint:CGPointMake(frame.size.width, height - 0.0)];
    [aPath closePath];
    
    CGContextSaveGState(context);
    [aPath addClip];
    
    CGContextDrawLinearGradient(context, simpleLinearGradient, CGPointMake(1.0, 0.0), CGPointMake(1.0, frame.size.height), 0);
    CGContextRestoreGState(context);
    
    [[UIColor blackColor] setStroke];
    aPath.lineWidth = 1;
    [aPath stroke];
    
    CGGradientRelease(simpleLinearGradient);
    CGColorSpaceRelease(colorSpace);
}

@end
