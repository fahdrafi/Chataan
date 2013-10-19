//
//  CTChartViewController.m
//  Chataan
//
//  Created by Fahd Rafi on 12/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTChartViewController.h"

#define ARC4RANDOM_MAX      0x100000000

//@interface CTChartViewController () {
//    NSArray* _values;
//}
//
//@end

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupRandomChart:) name:@"EntityClicked" object:nil];
    
}

- (void)setupRandomChart:(NSNotification*) notif {
    NSMutableArray* randomArray = [[NSMutableArray alloc] initWithCapacity:20];
    
    for (int i=0; i<20; i++) {
        [randomArray addObject:[NSNumber numberWithDouble:((double)arc4random() / ARC4RANDOM_MAX)]];
    }
    
    self.values = [NSArray arrayWithArray:randomArray];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
