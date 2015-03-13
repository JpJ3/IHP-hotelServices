//
//  LBSFHCommentsViewController.h
//  Hotel Services
//
//  Created by Mr John Platsis on 06/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JSCustomBadge.h"

@interface LBSFHCommentsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;

@property (strong, nonatomic) NSMutableAttributedString *commentString;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inboxButton;
@property (nonatomic) NSTimer *msgTimer;
@property (nonatomic) JSCustomBadge* inboxBadge;


@end
