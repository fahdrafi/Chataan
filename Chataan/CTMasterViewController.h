//
//  CTMasterViewController.h
//  Chataan
//
//  Created by Fahd Rafi on 10/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTDetailViewController;

@interface CTMasterViewController : UITableViewController

@property (strong, nonatomic) CTDetailViewController *detailViewController;

@end
