//
//  LBSFHSetAlarmViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 05/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHSetAlarmViewController.h"

@interface LBSFHSetAlarmViewController () 

@end

@implementation LBSFHSetAlarmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.inboxButton.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-320.jpg"]]];
    
    self.staticLabel.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.staticLabel.font= [UIFont fontWithName:@"Baskerville-Bold" size:20.0];

    self.staticTextfieldLabel.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.staticTextfieldLabel.font= [UIFont fontWithName:@"Baskerville-Bold" size:20.0];


    self.alarmTextField.delegate=self;
    self.alarmTextField.layer.borderColor=[[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.7]CGColor];
    self.alarmTextField.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.7];
    
    self.submitBtn.titleLabel.font=[UIFont fontWithName:@"Baskerville-BoldItalic" size:20.0];
    self.submitBtn.tintColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.submitBtn.backgroundColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.2];

    //MWdate piccker configuration
    MWDatePicker *datePicker = [[MWDatePicker alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-129, 130, 260, 150)];
    [datePicker setDelegate:self];
    
    // Set the type of Calendar the Dates should live in
    [datePicker setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]];
    [datePicker setFontColor:[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0]];
    [datePicker update];

    // Set the Minimum Date you want to show to the user
    [datePicker setMinimumDate:[NSDate date]];
    
    // Set the Date the Picker should show at the beginning
    [datePicker setDate:[NSDate date] animated:YES];
    
    
    [self.view addSubview:datePicker];

    
    //recognizes taps to dismiss keayboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    self.inboxBadge = [JSCustomBadge customBadgeWithString:@"ela mou"];
    [self.navigationController.toolbar addSubview:self.inboxBadge];
    self.inboxBadge.hidden=YES;

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

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self checkForMsges];
    self.msgTimer=[NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(checkForMsges) userInfo:nil repeats:YES];
    self.originalCenter = self.view.center;
}


#pragma mark helper Methods

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark TextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.view.center = CGPointMake(self.originalCenter.x, 100);
    [UIView commitAnimations];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.view.center = self.originalCenter;
    [UIView commitAnimations];

    NSLog(@"%@", self.alarmTextField.text);
    return YES;
}


- (IBAction)submitSelection:(id)sender {
    
   // NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    //NSDate *pickerDate = [_datePicker date];
    
    //NSString *selectionString = [[NSString alloc]initWithFormat:@"%@",[pickerDate descriptionWithLocale:usLocale]];
    
    //NSLog(@"%@ Dialexameeeee", selectionString);
    
    NSString *message;
    message = [NSString stringWithFormat:@"I am user %@, and I would like to set an alarm for:\n", [[PFUser currentUser] objectForKey:@"username"]];

    message= [message stringByAppendingString:self.selection];
    
    message= [message stringByAppendingString:@"\n\nRepeat pattern: \n"];
    
    message= [message stringByAppendingString:self.alarmTextField.text];
    
    message= [message stringByAppendingString:@"\n\nThank you."];
    
    PFObject *order = [PFObject objectWithClassName:@"Orders"];
    order[@"title"]= @"Set Alarm";
    order[@"message"] = message;
    order[@"completed"] = [NSNumber numberWithBool:NO];
    order[@"sender"] = [[PFUser currentUser] objectId];
    [order saveInBackground];
    
    [[[UIAlertView alloc] initWithTitle:@"Request Sent"
                                message:@"Your Request is now being sent"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];


}

-(void)dismissKeyboard {
    
    [self.alarmTextField resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.view.center = self.originalCenter;
    [UIView commitAnimations];
}

#pragma mark - MWPickerDelegate

-(void)datePicker:(MWDatePicker *)picker didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%@",[picker getDate]);
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    
    NSString *selectionString = [[NSString alloc]initWithFormat:@"%@",[[picker getDate] descriptionWithLocale:usLocale]];
    
    NSLog(@"%@ Dialexameeeee", selectionString);
    self.selection=selectionString;
}


- (UIColor *) viewColorForDatePickerSelector:(MWDatePicker *)picker
{
    return [UIColor grayColor];
}



@end
