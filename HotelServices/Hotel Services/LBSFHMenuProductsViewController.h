//
//  LBSFHMenuProductsViewController.h
//  Hotel Services
//
//  Created by Mr John Platsis on 22/07/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import <Parse/Parse.h>
#import "JSCustomBadge.h"

@interface LBSFHMenuProductsViewController : PFQueryTableViewController

@property (strong,nonatomic) NSArray *products;
@property (strong, nonatomic) NSString *title;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inboxButton;
@property (nonatomic) NSTimer *msgTimer;
@property (nonatomic) JSCustomBadge* inboxBadge;

@end
