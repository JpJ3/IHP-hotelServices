//
//  LBSFHLeaveACommentViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 07/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHLeaveACommentViewController.h"

@interface LBSFHLeaveACommentViewController ()

@end

@implementation LBSFHLeaveACommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.inboxButton.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-320.jpg"]]];
    
    self.staticLabel.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.staticLabel.font= [UIFont fontWithName:@"Baskerville-Bold" size:20.0];

    self.submitBtn.titleLabel.font=[UIFont fontWithName:@"Baskerville-BoldItalic" size:20.0];
    self.submitBtn.tintColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.submitBtn.backgroundColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.2];

    
    self.commentTextField.delegate=self;
    self.commentTextField.layer.borderColor=[[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.7]CGColor];
    self.commentTextField.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.7];

    //recognizes taps to dismiss keayboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.inboxBadge = [JSCustomBadge customBadgeWithString:@"ela mou"];
    [self.navigationController.toolbar addSubview:self.inboxBadge];
    self.inboxBadge.hidden=YES;

    // Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkForMsges];
    self.msgTimer=[NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(checkForMsges) userInfo:nil repeats:YES];
    
}



-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.msgTimer invalidate];
    self.msgTimer = nil;
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.inboxBadge removeFromSuperview];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    //self.view.center = self.originalCenter;
    NSLog(@"%@", self.commentTextField.text);
    return YES;
}

-(void)dismissKeyboard {
    
    [self.commentTextField resignFirstResponder];
    //self.view.center = self.originalCenter;
}

#pragma mark Helper Methods

-(void)checkForMsges {
    
    NSInteger messages =[[NSUserDefaults standardUserDefaults] integerForKey:@"Messages"];
    NSLog(@"%d", messages);
    
    if (messages!=0){
        NSLog(@"bike edw?? RESERVE");
        
        [self.inboxBadge autoBadgeSizeWithString:[NSString stringWithFormat:@"%d", messages]];
        self.inboxBadge.frame = CGRectMake(33, 6, 25, 22);
        [self.navigationController.toolbar addSubview:self.inboxBadge];
        self.inboxBadge.hidden=NO;
    }
    else {
        NSLog(@"I mipws edw?");
        self.inboxBadge.hidden=YES;
        
    }
    
}


- (IBAction)submitComment:(id)sender {
    
    PFObject *order = [PFObject objectWithClassName:@"Comments"];
    order[@"user"]= [[PFUser currentUser] objectForKey:@"username"];
    order[@"comment"] = self.commentTextField.text;
    [order saveInBackground];
    [self.commentTextField resignFirstResponder];
    
    [[[UIAlertView alloc] initWithTitle:@"Comment Sent"
                                message:@"Your comment is now being reviewed by our staff"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
