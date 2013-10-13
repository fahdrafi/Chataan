//
//  CTDetailViewController.m
//  Chataan
//
//  Created by Fahd Rafi on 10/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTDetailViewController.h"

@interface CTDetailViewController ()
@property (strong, nonatomic) NSDictionary* entityLabels;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation CTDetailViewController

#pragma mark - Managing the detail item

- (void)setEntityLinks:(NSDictionary *)entityLinks
{
    NSArray* entities = entityLinks.allKeys;
    
    float sum = 0.0;
    for (NSString* entity in entities) {
        assert([entityLinks[entity] floatValue] > 0.0);
        sum += [entityLinks[entity] floatValue];
        
    }
    assert(sum > 0.001);
    
    NSMutableDictionary *tempLinks = [[NSMutableDictionary alloc] initWithCapacity:entities.count];
    for (NSString* entity in entities) {
        NSNumber* weight = entityLinks[entity];
        weight = [NSNumber numberWithFloat:[weight floatValue]/sum];
        tempLinks[entity] = weight;
    }
    
    _entityLinks = [NSDictionary dictionaryWithDictionary:tempLinks];
    
    [self configureView];

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

CGFloat toEven(CGFloat f) {
    NSNumber* n = [NSNumber numberWithFloat:f];
    int i = [n intValue];
    i+=1;
    i+=(i%2);
    return i * 1.0;
}

- (void)configureView
{
    // Update the user interface for the detail item.
    NSArray* entities = self.entityLinks.allKeys;

    NSMutableDictionary* tempEntityLabels = [[NSMutableDictionary alloc] initWithCapacity:_entityLinks.count];
    CGFloat size = self.entitiesView.frame.size.height<self.entitiesView.frame.size.width?self.entitiesView.frame.size.height:self.entitiesView.frame.size.width;
    
    for (NSString* entity in entities) {
        tempEntityLabels[entity] = [[UILabel alloc] initWithFrame:CGRectMake(self.entitiesView.center.x, self.entitiesView.center.y, toEven(size * [_entityLinks[entity] floatValue]), toEven(size * [_entityLinks[entity] floatValue]))];
    }
    self.entityLabels = [NSDictionary dictionaryWithDictionary:tempEntityLabels];
    
    float cumulativeWeight = 0.0;
    for (NSString* entity in entities) {
        UILabel *label = self.entityLabels[entity];
        CGRect frame = label.frame;
        frame.origin.y = self.entitiesView.frame.size.height/2 - label.frame.size.height/2;
        frame.origin.x = cumulativeWeight * self.entitiesView.frame.size.width;
        label.frame = frame;
        label.layer.cornerRadius = frame.size.width / 2.0;
        
        label.backgroundColor = [UIColor lightGrayColor];
        label.text = entity;
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Helvetica" size:40.0];
        label.adjustsFontSizeToFitWidth = true;
        label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        
        
        [self.entitiesView addSubview:label];
        cumulativeWeight+= [_entityLinks[entity] floatValue];
    }
    
    //[self.view setNeedsDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
