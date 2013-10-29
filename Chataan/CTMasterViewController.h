//
//  CTMasterViewController.h
//  Chataan
//
//  Created by Fahd Rafi on 10/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTDetailViewController;

@interface CTMasterViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UINavigationController* navController;
@property (nonatomic) int depth;
@property (nonatomic, readonly) NSMutableArray* entityStack;

- (void)insertNewEntity:(NSDictionary*)entity;
//@property (strong, nonatomic) CTDetailViewController *detailViewController;

@end
