//
//  CTChartView.m
//  Chataan
//
//  Created by Fahd Rafi on 12/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTChartView.h"

@implementation CTChartView

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
    
    [[UIColor blackColor] setStroke];
    [[UIColor blueColor] setFill];
    aPath.lineWidth = 2;
    [aPath fill];
    [aPath stroke];
    // Set the starting point of the shape.
    
    // Draw the lines.
}

@end
