//
//  LBSFHMenuViewController.h
//  Hotel Services
//
//  Created by Mr John Platsis on 14/06/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import <Parse/Parse.h>
#import "JSCustomBadge.h"

@interface LBSFHMenuViewController : PFQueryTableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *inboxButton;
@property (nonatomic) NSTimer *msgTimer;
@property (nonatomic) JSCustomBadge* inboxBadge;

@end
