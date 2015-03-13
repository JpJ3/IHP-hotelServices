//
//  LBSFHSetAlarmViewController.h
//  Hotel Services
//
//  Created by Mr John Platsis on 05/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JSCustomBadge.h"
#import "MWDatePicker.h"


@interface LBSFHSetAlarmViewController : UIViewController <UITextFieldDelegate,MWPickerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *staticTextfieldLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *staticLabel;
@property (weak, nonatomic) IBOutlet UITextField *alarmTextField;
@property CGPoint originalCenter;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inboxButton;
@property (nonatomic) NSTimer *msgTimer;
@property (nonatomic) JSCustomBadge* inboxBadge;
@property (nonatomic) NSString *selection;


@end
