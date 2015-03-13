//
//  LBSFHSpaServicesViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 12/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHSpaServicesViewController.h"
#import "LBSFHSpaServicePackagesViewController.h"
#import "MSCellAccessory.h"

@interface LBSFHSpaServicesViewController ()

@end

@implementation LBSFHSpaServicesViewController

#pragma mark - ParseTableViewMethods

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        
        NSLog((@"init me ta coders"));
        // The className to query on
        self.parseClassName = @"SpaServices";
        
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
    static NSString *cellIdentifier = @"SpaServicesCell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    //configuration
    
    cell.textLabel.text = [object objectForKey:@"name"];
    cell.textLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:24.0];
    cell.textLabel.textColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];

    
    cell.detailTextLabel.text = [object objectForKey:@"description"];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:12.0];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *darkerColor = [[UIView alloc] init];
    darkerColor.backgroundColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.52f alpha:0.4];
    cell.selectedBackgroundView = darkerColor;
    
    cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0]];

    
    return cell;
}



- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    
    return query;
}

#pragma mark - ViewMethods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.inboxButton.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-320.jpg"]]];
    self.tableView.separatorColor= [UIColor clearColor];

    self.inboxBadge = [JSCustomBadge customBadgeWithString:@"ela mou"];
    [self.navigationController.toolbar addSubview:self.inboxBadge];
    self.inboxBadge.hidden=YES;
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

#pragma mark - Helper Methods


-(void)checkForMsges {
    
    NSInteger messages =[[NSUserDefaults standardUserDefaults] integerForKey:@"Messages"];
    NSLog(@"%d", messages);
    
    if (messages!=0){
        NSLog(@"bike edw??");
        
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SpaServicePackagesSegue"]) {
        LBSFHSpaServicePackagesViewController *packageView = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object= self.objects[indexPath.row];
        NSArray *packages= [object objectForKey:@"packages"];
        packageView.packages=packages;
        packageView.title=[object objectForKey:@"name"];
    }
   
}


@end
