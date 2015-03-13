//
//  LBSFHMenuProductDetailViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 30/07/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHMenuProductDetailViewController.h"
#import "LBSFHCartTableViewController.h"
#import <Parse/Parse.h>

@interface LBSFHMenuProductDetailViewController ()

@end

@implementation LBSFHMenuProductDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-320.jpg"]]];
    
    self.inboxButton.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];


    NSArray *cart = [[[NSUserDefaults standardUserDefaults] objectForKey:self.key] copy];
    
    if(cart == nil){
        
        self.cart= [[NSMutableArray alloc]init];
        NSLog(@" STO NIL EIMAI %@", self.cart);
    }
    else {
        self.cart = [cart mutableCopy];
        NSLog(@" STO MUTABLECOPY EIMAI %@", self.cart);
        //[self.RoomServiceCart addObject:self.specialInstructions.text];
    }
    //set textfield delegate
    self.specialInstructions.delegate=self;
    self.specialInstructions.layer.borderColor=[[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.7]CGColor];
    self.specialInstructions.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.7];
    
    //sest title
    self.navigationItem.title= [self.product objectForKey:@"name"];
    
    self.productDescription.text = [self.product objectForKey:@"description"];
    self.productDescription.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.productDescription.font=[UIFont fontWithName:@"Baskerville-BoldItalic" size:16.0];
    
    self.priceLabel.text=[NSString stringWithFormat:@"Price: %@", self.product[@"price"]];
    self.priceLabel.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.priceLabel.font=[UIFont fontWithName:@"Baskerville-Bold" size:17.0];

    self.staticDescription.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.staticDescription.font= [UIFont fontWithName:@"Baskerville-Bold" size:17.0];
    
    self.staticSpecialInstruction.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.staticSpecialInstruction.font=[UIFont fontWithName:@"Baskerville-Bold" size:17.0];
    
    self.staticQty.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.staticQty.font=[UIFont fontWithName:@"Baskerville-Bold" size:17.0];
    
    self.pickerTitles = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    
    self.addButton.titleLabel.font=[UIFont fontWithName:@"Baskerville-BoldItalic" size:16.0];
    self.addButton.tintColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.addButton.backgroundColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.2];

    //[buttonName setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    
    //recognizes taps to dismiss keayboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    //image configuration
    
    PFFile *thumbnail = [self.product objectForKey:@"imageFile"];
    //self.thumbnailImageView= [[PFImageView alloc] init];
    self.thumbnailImageView.image = [UIImage imageNamed:@"app icon.png"];
    self.thumbnailImageView.file = thumbnail;
    CALayer *imageLayer = self.thumbnailImageView.layer;
    //make it circle-like
    [imageLayer setCornerRadius:45];
    [imageLayer setBorderWidth:3];
    [imageLayer setBorderColor: [[UIColor colorWithRed:1.0 green:0.16f blue:0.52f alpha:0.4] CGColor]];
    [imageLayer setMasksToBounds:YES];
    [self.thumbnailImageView loadInBackground];
    
    self.inboxBadge = [JSCustomBadge customBadgeWithString:@"ela mou"];
    [self.navigationController.toolbar addSubview:self.inboxBadge];
    self.inboxBadge.hidden=YES;
    
}


- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    self.pickerSelection =1;
    
    self.originalCenter = self.view.center;
    
    
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


#pragma mark - PickerView DataSource

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerTitles.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.pickerTitles[row];
}


#pragma mark PickerView Delegate 

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    self.pickerSelection = row+1;
    NSLog(@"the user selected %d products", self.pickerSelection);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    NSInteger number =row+1;
    NSString *name = [NSString stringWithFormat:@"%d", number];
    label.text = name;
    label.textColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.52f alpha:1.0];
    label.font=[UIFont fontWithName:@"Baskerville-Bold" size:22.0];
    return label;
}
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
    
    NSLog(@"%@", self.specialInstructions.text);
    return YES;
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


- (IBAction)addToCart:(id)sender {
    
    NSMutableDictionary *cartObject;
    cartObject = [[NSMutableDictionary alloc] init];
    [cartObject setObject:self.specialInstructions.text forKey:@"specialInstructions"];
    [cartObject setObject:[self.product objectForKey:@"name"] forKey:@"name"];
    [cartObject setObject:[NSNumber numberWithInteger:self.pickerSelection] forKey:@"QTY"];
    [cartObject setObject:[self.product objectForKey:@"price"] forKey:@"productPrice"];
    
    NSLog(@"%@", cartObject);
    [self.cart addObject:cartObject];
    
    NSLog(@"%@", self.cart);
    
    
    [[NSUserDefaults standardUserDefaults] setObject:self.cart forKey:self.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[[UIAlertView alloc] initWithTitle:@"Success"
                                message:@"The Item(s) were added to cart"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];

}

-(void)dismissKeyboard {
    
    [self.specialInstructions resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.view.center = self.originalCenter;
    [UIView commitAnimations];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"CartSegue"]) {
        LBSFHCartTableViewController *productDetailView = [segue destinationViewController];
        
        
        if ([self.key isEqualToString:@"RoomServiceCart"]) {
            
            productDetailView.key = @"RoomServiceCart";
        }
        else {
            productDetailView.key = @"PoolBarCart";
        }

        
    }
}




@end
