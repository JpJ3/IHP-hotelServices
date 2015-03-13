//
//  LBSFHViewController.h
//  Hotel Services
//
//  Created by Mr John Platsis on 10/06/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JSCustomBadge.h"

@interface LBSFHViewController : UIViewController <PFLogInViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *upRightCorner;
@property (strong, nonatomic) IBOutlet UIImageView *bottomRightCorner;
@property (strong, nonatomic) IBOutlet UIImageView *bottomLeftCorner;
@property (strong, nonatomic) IBOutlet UIImageView *upLeftCorner;
@property (weak, nonatomic) IBOutlet UIImageView *imView;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *inboxButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (nonatomic) NSInteger viewCountLauncher;
@property (nonatomic) NSArray *services;
@property (nonatomic) NSString *QRcode;
@property (nonatomic) NSTimer *msgTimer;
@property (nonatomic) JSCustomBadge* inboxBadge;
@property (nonatomic, strong) CAShapeLayer *outline;


@end


