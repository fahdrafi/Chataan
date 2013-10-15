//
//  CTGraphViewController.m
//  Chataan
//
//  Created by Fahd Rafi on 15/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTGraphViewController.h"

@interface CTGraphViewController ()
@property (strong, nonatomic) NSDictionary* entityLabels;
@end

@implementation CTGraphViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    CGFloat size = self.view.frame.size.height<self.view.frame.size.width?self.view.frame.size.height:self.view.frame.size.width;
    
    for (NSString* entity in entities) {
        tempEntityLabels[entity] = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, toEven(size * [_entityLinks[entity] floatValue]), toEven(size * [_entityLinks[entity] floatValue]))];
    }
    self.entityLabels = [NSDictionary dictionaryWithDictionary:tempEntityLabels];
    
    float cumulativeWeight = 0.0;
    for (NSString* entity in entities) {
        UILabel *label = self.entityLabels[entity];
        CGRect frame = label.frame;
        frame.origin.y = self.view.frame.size.height/2 - label.frame.size.height/2;
        frame.origin.x = cumulativeWeight * self.view.frame.size.width;
        label.frame = frame;
        label.layer.cornerRadius = frame.size.width / 2.0;
        
        label.backgroundColor = [UIColor lightGrayColor];
        label.text = entity;
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Helvetica" size:40.0];
        label.adjustsFontSizeToFitWidth = true;
        label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        
        
        [self.view addSubview:label];
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

@end
