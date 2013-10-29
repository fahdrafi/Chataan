//
//  CTAppDelegate.m
//  Chataan
//
//  Created by Fahd Rafi on 10/10/2013.
//  Copyright (c) 2013 Fahd Rafi. All rights reserved.
//

#import "CTAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "CTDataController.h"
#import "CTMasterViewController.h"

@interface CTAppDelegate () {
    CTDataController* _dataController;
}

@property (strong, nonatomic) UINavigationController* navigationController;
@property (nonatomic, readonly) CTDataController* dataController;

@end

@implementation CTAppDelegate

- (CTDataController*)dataController {
    if (!_dataController)
        _dataController = [CTDataController sharedController];
    return _dataController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    self.navigationController = [splitViewController.viewControllers firstObject];
    //splitViewController.delegate = (id)self.navigationController.topViewController;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNewMasterList:) name:@"PushNewMasterList" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(populateMasterList:) name:@"MasterListLoaded" object:nil];
    
    return YES;
}

- (void)populateMasterList:(NSNotification*)notif {
    CTMasterViewController* masterListCon = notif.object;
    
    NSDictionary* entities = self.dataController[@"Entities"];
    
    for (NSString* entityKey in entities) {
        NSDictionary* entity = entities[entityKey];
        [masterListCon insertNewEntity:entity];
    }
}

- (void)pushNewMasterList:(NSNotification*)notif {
    CTMasterViewController* newListCon = notif.object;
    NSDictionary* linkedEntities = newListCon.entityStack.lastObject[@"LinkedEntities"];
    
    for (NSString* entityKey in linkedEntities) {
        NSDictionary* entity = linkedEntities[entityKey];
        [newListCon insertNewEntity:entity];
    }

    [self.navigationController pushViewController:newListCon animated:true];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // We need to properly handle activation of the application with regards to Facebook Login
    // (e.g., returning from iOS 6.0 Login Dialog or from fast app switching).
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
