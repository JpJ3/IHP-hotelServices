//
//  LBSFHReservationFormViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 13/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHReservationFormViewController.h"

@interface LBSFHReservationFormViewController ()

@end

@implementation LBSFHReservationFormViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    /*CALayer *imageLayer = self.pickerBackgroundImg.layer;
    //make it circle-like
    [imageLayer setCornerRadius:45];
    [imageLayer setBorderWidth:3];
    [imageLayer setBorderColor: [[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.55] CGColor]];
    [imageLayer setMasksToBounds:YES];*/
    
    
    self.staticLabel.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.staticLabel.font= [UIFont fontWithName:@"Baskerville-Bold" size:20.0];

    self.submitButton.titleLabel.font=[UIFont fontWithName:@"Baskerville-BoldItalic" size:20.0];
    self.submitButton.backgroundColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.2];
    self.submitButton.tintColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];

    
    //MWdate piccker configuration
    
    MWDatePicker *datePicker = [[MWDatePicker alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-129, 130, 260, 150)];
    
    [datePicker setDelegate:self];
    
    // Set the type of Calendar the Dates should live in
    [datePicker setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]];
    [datePicker setFontColor:[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0]];
    //[datePicker setBackgroundColor:[UIColor redColor]];
    [datePicker update];
    
    // Set the Minimum Date you want to show to the user
    [datePicker setMinimumDate:[NSDate date]];
    
    // Set the Date the Picker should show at the beginning
    [datePicker setDate:[NSDate date] animated:YES];
    
    
    [self.view addSubview:datePicker];


    self.inboxButton.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-320.jpg"]]];
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


#pragma mark - Helper Methods


- (IBAction)submitReservation:(id)sender {
    /*NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *pickerDate = [_datePicker date];
    
    NSString *selectionString = [[NSString alloc]initWithFormat:@"%@",[pickerDate descriptionWithLocale:usLocale]];
    
    NSLog(@"%@ Dialexameeeee", selectionString);*/

    NSString *message;
    message = [NSString stringWithFormat:@"I am user %@, and I would like make a reservation for", [[PFUser currentUser] objectForKey:@"username"]];
    
    if ([self.reservation isEqualToString:@"restaurant"]){
        message = [message stringByAppendingString:@" the restaurant at:\n"];
    
    }
    else{
        message=[message stringByAppendingString:@" the "];
        message=[message stringByAppendingString:self.spaPackage];
        message=[message stringByAppendingString:@" package of the "];
        message=[message stringByAppendingString:self.spaService];
        message=[message stringByAppendingString:@" service the spa is offering at:\n"];
    }
    
    message= [message stringByAppendingString:self.selection];
    message= [message stringByAppendingString:@"\nif available please. Thank You"];

    PFObject *order = [PFObject objectWithClassName:@"Orders"];
    order[@"title"]= @"Reservation Request";
    order[@"message"] = message;
    order[@"completed"] = [NSNumber numberWithBool:NO];
    order[@"sender"] = [[PFUser currentUser] objectId];
    [order saveInBackground];
    
    //NSLog(@"%@", message);
    
    [[[UIAlertView alloc] initWithTitle:@"Request Sent"
                                message:@"Your Request is now being sent"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    
    

}

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
