//
//  LBSFHCommentsViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 06/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHCommentsViewController.h"

@interface LBSFHCommentsViewController ()

@end

@implementation LBSFHCommentsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.inboxButton.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    [self.commentsTextView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-320.jpg"]]];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.inboxBadge = [JSCustomBadge customBadgeWithString:@"ela mou"];
    [self.navigationController.toolbar addSubview:self.inboxBadge];
    self.inboxBadge.hidden=YES;    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    [self loadComments];
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
    //self.inboxBadge.hidden=YES;
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


#pragma mark - Helper Methods


-(void) loadComments {
    
    self.commentString = [[NSMutableAttributedString alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Comments"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"%@", objects);
                for (PFObject *object in objects){
                    NSString *string1= [object objectForKey:@"user"];
                    string1=[string1 stringByAppendingString:@":\n"];
                    
                    UIFont * string1Font = [UIFont fontWithName:@"Baskerville-Bold" size:20];
                    UIColor * string1Color = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
                    
                    NSAttributedString *user = [[NSAttributedString alloc] initWithString : string1
                                                                                    attributes : @{
                                                                                                   NSFontAttributeName : string1Font,
                                                                                                   NSForegroundColorAttributeName : string1Color,
                                                                        }];
                    NSString *string2= [object objectForKey:@"comment"];
                    string2=[string2 stringByAppendingString:@"\n\n"];
                    
                    UIFont * string2Font = [UIFont fontWithName:@"Baskerville-Bold" size:17];
                    UIColor * string2Color = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
                    
                    NSAttributedString *comment = [[NSAttributedString alloc] initWithString : string2
                                                                                    attributes : @{
                                                                                                   NSFontAttributeName : string2Font,
                                                                                                   NSForegroundColorAttributeName : string2Color,
                                                                                                   }];
                   
   
                    [self.commentString appendAttributedString:user];
                    [self.commentString appendAttributedString:comment];


            }
            
        }
        else
        {
            
        }
        self.commentsTextView.attributedText=self.commentString;

    }];

    
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
