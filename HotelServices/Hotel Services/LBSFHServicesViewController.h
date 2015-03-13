//
//  LBSFHServicesViewController.h
//  Hotel Services
//
//  Created by Mr John Platsis on 11/06/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import <Parse/Parse.h>
#import "JSCustomBadge.h"

@interface LBSFHServicesViewController : PFQueryTableViewController

@property (nonatomic) NSString * locationName;

@property (nonatomic) NSArray *services;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *inboxButton;

@property (nonatomic) NSTimer *msgTimer;

@property (nonatomic) JSCustomBadge* inboxBadge;


@end


