//
//  LBSFHServicesViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 11/06/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHServicesViewController.h"
#import "LBSFHMenuViewController.h"
#import "MSCellAccessory.h"


@interface LBSFHServicesViewController ()

@end

@implementation LBSFHServicesViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.inboxButton.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-320.jpg"]]];

    self.tableView.separatorColor = [UIColor clearColor];
    


    self.title=self.locationName;
    
    self.inboxBadge = [JSCustomBadge customBadgeWithString:@"ela mou"];
    [self.navigationController.toolbar addSubview:self.inboxBadge];
    self.inboxBadge.hidden=YES;
    
}

-(void)viewDidAppear:(BOOL)animated{
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

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        
        // The className to query on
        self.parseClassName = @"Services";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object
{
    static NSString *cellIdentifier = @"ServiceCell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    
    cell.textLabel.text = [object objectForKey:@"name"];
    cell.textLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:24.0];
    cell.textLabel.textColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    //cell bacjground color
    cell.backgroundColor = [UIColor clearColor];
    
    //selected color
    UIView *darkerColor = [[UIView alloc] init];
    darkerColor.backgroundColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.52f alpha:0.4];
    cell.selectedBackgroundView = darkerColor;
    
    //arrow color
    cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0]];
    
    
    return cell;
}


- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    
    //get the services
    self.services = [[[NSUserDefaults standardUserDefaults] objectForKey:@"services"] copy];
    self.locationName = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationName"];
    
    


    //[query whereKey:@"name" equalTo:@"Room 221"];
    [query whereKey:@"objectId" containedIn:self.services];
    
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    
    return query;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper methods

-(void)checkForMsges {
    
    NSInteger messages =[[NSUserDefaults standardUserDefaults] integerForKey:@"Messages"];
    NSLog(@"%d", messages);
    
    if (messages!=0){

        [self.inboxBadge autoBadgeSizeWithString:[NSString stringWithFormat:@"%d", messages]];
        self.inboxBadge.frame = CGRectMake(33, 6, 25, 22);
        [self.navigationController.toolbar addSubview:self.inboxBadge];
        self.inboxBadge.hidden=NO;
    }
    else {
        self.inboxBadge.hidden=YES;
    }

}

- (IBAction)turnBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark - Navigation

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *object= self.objects[indexPath.row];
    NSString *name = object[@"name"];
    
    if ([name isEqualToString:@"Room Service"]) {
        
        [self performSegueWithIdentifier:@"MenuSegue" sender:self];
        
    }
    
    else if ([name isEqualToString:@"Set Alarm"]){
        
        [self performSegueWithIdentifier:@"SetAlarmSegue" sender:self];
        
    }
    
    else if ([name isEqualToString:@"Pool Bar Comments"]){
        
        [self performSegueWithIdentifier:@"CommentsSegue" sender:self];
        
    }
    else if ([name isEqualToString:@"Ask A Question"]){
        
        [self performSegueWithIdentifier:@"AskAQuestionsegue" sender:self];
        
    }
    else if ([name isEqualToString:@"Reservations"]){
        
        [self performSegueWithIdentifier:@"ReservationsSegue" sender:self];
        
    }
    else if ([name isEqualToString:@"Pool Bar Menu"]){
        
        [self performSegueWithIdentifier:@"MenuSegue" sender:self];

    }
    
        
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
       if ([[segue identifier] isEqualToString:@"MenuSegue"]) {
        LBSFHMenuViewController *productView = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
           PFObject *object= self.objects[indexPath.row];
           NSString *name = object[@"name"];
           if ([name isEqualToString:@"Room Service"]) {
               
               productView.parseClassName=@"RoomServiceMenuCategories";
               
           }
           else{
               productView.parseClassName=@"PoolBarMenuCategories";

           }
      }
    
}




@end
