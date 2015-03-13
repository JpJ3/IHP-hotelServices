//
//  LBSFHReservationFormViewController.h
//  Hotel Services
//
//  Created by Mr John Platsis on 13/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JSCustomBadge.h"
#import "MWDatePicker.h"


@interface LBSFHReservationFormViewController : UIViewController <MWPickerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *staticLabel;
@property (nonatomic) NSString *reservation;
@property (nonatomic) NSString *spaService;
@property (nonatomic) NSString *spaPackage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inboxButton;
@property (nonatomic) NSTimer *msgTimer;
@property (nonatomic) JSCustomBadge* inboxBadge;
@property (nonatomic) NSString *selection;



@end
