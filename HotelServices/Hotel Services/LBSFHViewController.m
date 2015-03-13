//
//  LBSFHViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 10/06/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHViewController.h"
#import <Parse/Parse.h>
#import "MyLogInViewController.h"
#import <AudioToolbox/AudioServices.h>
#import "LBSFHServicesViewController.h"


@import AVFoundation;

@interface LBSFHViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (strong) AVCaptureSession *captureSession;

@end

@implementation LBSFHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewdidload");

    
    self.captureSession = [[AVCaptureSession alloc] init];
    AVCaptureDevice *videoCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoCaptureDevice error:&error];
    if(videoInput)
        [self.captureSession addInput:videoInput];
    else
        NSLog(@"Error: %@", error);
    
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:metadataOutput];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [metadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    previewLayer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:previewLayer];
    
    
    self.label.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.label.font= [UIFont fontWithName:@"Baskerville-Bold" size:19.0];
    
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.logoutButton];
    [self.view addSubview:self.inboxButton];
    [self.view addSubview:self.infoButton];

    
    [self.captureSession startRunning];
    
   
    [self checkForMsges];
    self.msgTimer=[NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(checkForMsges) userInfo:nil repeats:YES];

    /*MLPAccessoryBadge *accessoryBadge;
    accessoryBadge = [MLPAccessoryBadgeChevron new];
    [accessoryBadge setCornerRadius:100];
    [accessoryBadge setTextWithNumber:@2];
    [accessoryBadge setBackgroundColor:[UIColor redColor]];
    CGRect theFrame = accessoryBadge.frame;
    theFrame.origin.x += 40;
    theFrame.origin.y +=20;
    accessoryBadge.frame = theFrame;
    //[self.view addSubview:accessoryBadge];*/
    
    //rotate the arrows
    
    //[self.view addSubview:self.upLeftCorner];
    //float degrees = 135;
    

    self.upLeftCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up4-100.png"]];

    self.upLeftCorner.transform = CGAffineTransformMakeRotation(-0.785398163);
    //[self.upLeftCorner setFrame:CGRectMake(0, 0, 50, 50)];
    CGPoint point0 = self.upLeftCorner.layer.position;
    CGPoint point1 = { point0.x-30, point0.y+ 110 };
    self.upLeftCorner.layer.position=point1;

    
    [self.view addSubview:self.upLeftCorner];
    
    self.upRightCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up4-100.png"]];
    
    self.upRightCorner.transform = CGAffineTransformMakeRotation(0.785398163);
    CGPoint point2 = self.upRightCorner.layer.position;
    CGPoint point3 = { point2.x+250, point2.y+ 113 };
    self.upRightCorner.layer.position=point3;
    
    
    [self.view addSubview:self.upRightCorner];
    
    self.bottomLeftCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up4-100.png"]];
    
    self.bottomLeftCorner.transform = CGAffineTransformMakeRotation(-2.35619449);
    CGPoint point4 = self.bottomLeftCorner.layer.position;
    CGPoint point5 = { point4.x-30, point4.y+ 445 };
    self.bottomLeftCorner.layer.position=point5;
    
    
    [self.view addSubview:self.bottomLeftCorner];
    
    self.bottomRightCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up4-100.png"]];
    
    self.bottomRightCorner.transform = CGAffineTransformMakeRotation(2.35619449);
    CGPoint point6 = self.bottomRightCorner.layer.position;
    CGPoint point7 = { point6.x+250, point6.y+445 };
    self.bottomRightCorner.layer.position=point7;
    
    
    [self.view addSubview:self.bottomRightCorner];



    self.inboxBadge = [JSCustomBadge customBadgeWithString:@"ela mou"];
    [self.view addSubview:self.inboxBadge];
    self.inboxBadge.hidden=YES;

}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    for(AVMetadataObject *metadataObject in metadataObjects)
    {
        AVMetadataMachineReadableCodeObject *readableObject = (AVMetadataMachineReadableCodeObject *)metadataObject;
        if([metadataObject.type isEqualToString:AVMetadataObjectTypeQRCode])
        {
            
            //NSLog(@"QR Code = %@", readableObject.stringValue);
            self.QRcode = readableObject.stringValue;
        }
    }
    
    
    //to dispatch_one se periptwsi pou to xreiastw to afinw
    //NSLog(@"poses fores");
    /*static dispatch_once_t once;
    dispatch_once(&once, ^ {
        [self performSegueWithIdentifier:@"NavControllersegue" sender:self];
    });*/
    //[self.captureSession stopRunning];
    
    
    
    //to make sure view launches once
    
    if (self.viewCountLauncher == 0){
        NSLog(@"%d poses fores", self.viewCountLauncher);
        self.viewCountLauncher++;
        [self LaunchTableview];
    }
}


#pragma mark - Helper Methods

- (IBAction)logoutUser:(id)sender {
    
    [PFUser logOut];
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
        
        // Set ourselves as the delegate
        [logInViewController setDelegate:self];
        
        //set the fields we want to appear
        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsPasswordForgotten | PFLogInFieldsLogInButton;
        
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }

    
    
}

-(void) LaunchTableview{
    
    

    PFQuery *query = [PFQuery queryWithClassName:@"Locations"];
    
    [query whereKey:@"QRcode" equalTo:self.QRcode];

    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            
            //this command vibrates the phone
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

            self.services = [object objectForKey:@"services"];
            NSLog(@"%@ launcahroume??", self.services);
            NSString *locationName = [object objectForKey:@"name"];
            //fortwse ta NSUserDefaults
            
            [[NSUserDefaults standardUserDefaults] setObject:locationName forKey:@"LocationName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:self.services forKey:@"services"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            

            //anoikse to tableview
            [self performSegueWithIdentifier:@"NavControllersegue" sender:self];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [[[UIAlertView alloc] initWithTitle:@"QR Code not available"
                                        message:@"The QR Code you scanned does not belong to this hotel"
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
                            self.viewCountLauncher=0;

        }
        
    }];
    
   }

-(void) checkForMsges {
    if ([PFUser currentUser]){
    PFQuery *query = [PFQuery queryWithClassName:@"Answers"];
    [query whereKey:@"intendedUser" equalTo:[[PFUser currentUser] objectId]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            int unreadMessages=0;
            for (PFObject *object in objects){
                if ([[object objectForKey:@"read"]isEqual:[NSNumber numberWithBool:false]]){
                    unreadMessages++;
                }
                
            }
            if (unreadMessages==0){
                self.inboxBadge.hidden=YES;
                //[self.inboxBadge removeFromSuperview];

            }
            else {
                [self.inboxBadge autoBadgeSizeWithString:[NSString stringWithFormat:@"%d", unreadMessages]];
                 self.inboxBadge.frame = CGRectMake(30, 20, 25, 22);
                 self.inboxBadge.hidden=NO;

            }

            NSLog(@"%d", unreadMessages);
            [[NSUserDefaults standardUserDefaults] setInteger:unreadMessages forKey:@"Messages"];
            [[NSUserDefaults standardUserDefaults] synchronize];        }
        else
        {
            
        }
    }];
    
    }
}

/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //pass the qrcode scanned
    
    PFQuery *query = [PFQuery queryWithClassName:@"Locations"];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            self.services = [object objectForKey:@"services"];
            NSLog(@"%@ seguaroume??", self.services);
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
    
    //save qrcode in user defaults
    NSInteger index = 221;
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"QRcode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.services forKey:@"services"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}*/

- (void)addAnimation:(NSNotification *)notificaiton
{
    //red line animations
    
    [self.view addSubview:self.imView];
    
    CGPoint point0 = self.imView.layer.position;
    CGPoint point1 = { point0.x, point0.y+ 300 };
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    anim.fromValue    = @(point0.y);
    anim.toValue  = @(point1.y);
    anim.duration   = 4.0f;
    anim.repeatCount=150.0;
    anim.autoreverses=YES;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // First we update the model layer's property.
    //self.imView.layer.position = point1;
    
    // Now we attach the animation.
    [self.imView.layer  addAnimation:anim forKey:@"position.y"];

   }

#pragma mark - View Lifecycle Delegate

// to set again the viewcounter to zero

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    self.viewCountLauncher = 0;
    [self checkForMsges];
    
    //red line animations
    
    [self.view addSubview:self.imView];
    
    CGPoint point0 = self.imView.layer.position;
    CGPoint point1 = { point0.x, point0.y+ 300 };
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    anim.fromValue    = @(point0.y);
    anim.toValue  = @(point1.y);
    anim.duration   = 4.0f;
    anim.repeatCount=150.0;
    anim.autoreverses=YES;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // First we update the model layer's property.
    //self.imView.layer.position = point1;
    
    // Now we attach the animation.
    [self.imView.layer  addAnimation:anim forKey:@"position.y"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnimation:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.inboxBadge.hidden=YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");

    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
        
        // Set ourselves as the delegate
        [logInViewController setDelegate:self];
        
        //set the fields we want to appear
        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsPasswordForgotten | PFLogInFieldsLogInButton;
        
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
        
            }

    
}

#pragma mark - Sign In View Delegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    }

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"Login Failed"
                                message:@"Make sure you used the correct username and password! If you have forgotten your password you can reset it"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    
}

- (IBAction)openInfo:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
}


@end
