//
//  LBSFHMenuProductsViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 22/07/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHMenuProductsViewController.h"
#import "LBSFHMenuProductDetailViewController.h"
#import "LBSFHCartTableViewController.h"
#import "MSCellAccessory.h"


@interface LBSFHMenuProductsViewController ()

@end

@implementation LBSFHMenuProductsViewController



#pragma mark - ParseTableViewMethods

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        
        NSLog((@"init me ta coders"));
        // The className to query on
        //self.parseClassName = @"RoomServiceMenuProducts";
        
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
    static NSString *cellIdentifier = @"RoomServiceProductsCell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    //configuration
    
    /*PFFile *thumbnail = [object objectForKey:@"imageFile"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:200];
    thumbnailImageView.image = [UIImage imageNamed:@"app icon.png"];
    [thumbnail getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        thumbnailImageView.image=[UIImage imageWithData:data];
    }];*/
    
    PFFile *thumbnail = [object objectForKey:@"imageFile"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:200];
    thumbnailImageView.image = [UIImage imageNamed:@"app icon.png"];
    thumbnailImageView.file = thumbnail;
    CALayer *imageLayer = thumbnailImageView.layer;
    //make it circle-like
    [imageLayer setCornerRadius:45];
    [imageLayer setBorderWidth:1];
    [imageLayer setMasksToBounds:YES];
    [thumbnailImageView loadInBackground];
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:201];
    nameLabel.text = [object objectForKey:@"name"];
    nameLabel.font =[UIFont fontWithName:@"Baskerville-BoldItalic" size:24.0];
    nameLabel.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    
    UILabel *priceLabel = (UILabel*) [cell viewWithTag:202];
    priceLabel.text = [NSString stringWithFormat:@"Price: %@", object[@"price"]];
    priceLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:14.0];
    priceLabel.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *darkerColor = [[UIView alloc] init];
    darkerColor.backgroundColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.52f alpha:0.4];
    cell.selectedBackgroundView = darkerColor;

    cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0]];

    
    return cell;
}


- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    
    [query whereKey:@"objectId" containedIn:self.products];
    
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    
    return query;
}


#pragma mark - ViewMethods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.inboxButton.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-320.jpg"]]];

    self.tableView.separatorColor = [UIColor clearColor];

    
    
    self.navigationItem.title= self.title;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"RoomServiceProductsDetailSegue"]) {
    LBSFHMenuProductDetailViewController *productDetailView = [segue destinationViewController];
   
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        productDetailView.product = self.objects[indexPath.row];

    
     if ([self.parseClassName isEqualToString:@"RoomServiceMenuProducts"]) {
     
         productDetailView.key = @"RoomServiceCart";
        }
     else {
         productDetailView.key = @"PoolBarCart";
     }
    
    }
    else if ([[segue identifier] isEqualToString:@"CartSegue"]) {
        LBSFHCartTableViewController *productDetailView = [segue destinationViewController];
        
        
        if ([self.parseClassName isEqualToString:@"RoomServiceMenuProducts"]) {
            
            productDetailView.key = @"RoomServiceCart";
        }
        else {
            productDetailView.key = @"PoolBarCart";
        }

        
    }
    
}


@end
