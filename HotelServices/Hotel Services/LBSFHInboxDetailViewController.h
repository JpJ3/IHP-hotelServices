//
//  LBSFHInboxDetailViewController.h
//  Hotel Services
//
//  Created by Mr John Platsis on 22/07/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LBSFHInboxDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) PFObject *inbox;

@end
