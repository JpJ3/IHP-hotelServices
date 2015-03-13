//
//  LBSFHCartTableViewController.h
//  Hotel Services
//
//  Created by Mr John Platsis on 04/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JSCustomBadge.h"


@interface LBSFHCartTableViewController : UITableViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearButton;
@property (nonatomic) NSMutableArray *cart;
@property (strong, nonatomic) NSString *key;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inboxButton;
@property (nonatomic) NSTimer *msgTimer;
@property (nonatomic) JSCustomBadge* inboxBadge;

@end
