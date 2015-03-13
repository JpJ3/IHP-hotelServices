//
//  LBSFHAppDelegate.m
//  Hotel Services
//
//  Created by Mr John Platsis on 10/06/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHAppDelegate.h"
#import <Parse/Parse.h>
#import "LBSFHViewController.h"


@implementation LBSFHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [Parse setApplicationId:@"Fsb1efhWOQHWmZec4xi7b2UpTiQPtOZdje5dbp52"
                  clientKey:@"nRQg88FiQu216Iyvtow7ibft8Ihqi36vFQoStULD"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [self customizeUserInterface];
    
    return YES;
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Helper Methods


-(void) customizeUserInterface{
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.176 green:0.176 blue:0.176 alpha:1.0]];
    //[UIColor colorWithRed:1.0 green:0.063f blue:0.314f alpha:1.0]
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0], NSForegroundColorAttributeName, [UIFont fontWithName:@"AvenirNext-Italic" size:19.0], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0]];
}



@end
