//
//  LBSFHInboxDetailViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 22/07/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHInboxDetailViewController.h"
#import <Parse/Parse.h>

@interface LBSFHInboxDetailViewController ()

@end

@implementation LBSFHInboxDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.textView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-320.jpg"]]];

    
    NSString *inboxText=[self.inbox objectForKey:@"messages"];
    
    UIFont * string1Font = [UIFont fontWithName:@"Baskerville-Bold" size:20];
    UIColor * string1Color = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    NSAttributedString *text = [[NSAttributedString alloc] initWithString : inboxText
                                                               attributes : @{
                                                                              NSFontAttributeName : string1Font,
                                                                              NSForegroundColorAttributeName : string1Color,
                                                                              }];
    
    self.textView.attributedText=text;

    
    self.navigationItem.title= [self.inbox objectForKey:@"title"];
    
    self.inbox[@"read"] = [NSNumber numberWithBool:YES];
    [self.inbox saveInBackground];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
