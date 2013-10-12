//
//  CTChartViewController.m
//  Chataan
//
//  Created by Fahd Rafi on 12/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTChartViewController.h"

@interface CTChartViewController () {
    NSArray* _values;
}

@end

@implementation CTChartViewController

- (void)setValues:(NSArray*)newValues {
    _values = newValues;
    CTChartView* view = (CTChartView*)self.view;
    view.values = self.values;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
