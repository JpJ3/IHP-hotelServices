//
//  LBSFHSpaServicePackagesViewController.h
//  Hotel Services
//
//  Created by Mr John Platsis on 12/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import <Parse/Parse.h>
#import "JSCustomBadge.h"


@interface LBSFHSpaServicePackagesViewController : PFQueryTableViewController

@property (nonatomic) NSArray *packages;
@property (nonatomic) NSTimer *msgTimer;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inboxButton;
@property (nonatomic) NSString *title;
@property (nonatomic) JSCustomBadge* inboxBadge;

@end
