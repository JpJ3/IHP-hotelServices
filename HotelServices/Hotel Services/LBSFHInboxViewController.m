//
//  LBSFHInboxViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 19/07/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHInboxViewController.h"
#import "LBSFHInboxDetailViewController.h"
#import "MSCellAccessory.h"

@interface LBSFHInboxViewController ()

@end

@implementation LBSFHInboxViewController

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        
        NSLog((@"init me ta coders"));
        // The className to query on
        self.parseClassName = @"Answers";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"title";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
    }
    return self;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    [query whereKey:@"intendedUser" equalTo:[[PFUser currentUser] objectId]];
    [query orderByDescending:@"createdAt"];
    
    
    return query;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object
{
    static NSString *cellIdentifier = @"InboxCell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    
    //configuration
    
    cell.textLabel.text = [object objectForKey:@"title"];
    
    NSDate *createdAt = object.createdAt;
    NSString *temp = [NSString stringWithFormat:@"%@", createdAt];
    NSArray *split = [temp componentsSeparatedByString:@" "];
    NSString *dateAndTime= [NSString stringWithFormat:@"%@ %@", [split objectAtIndex:0], [split objectAtIndex:1]];
    cell.detailTextLabel.text = dateAndTime;
    
    if ([[object objectForKey:@"read"]isEqual:[NSNumber numberWithBool:false]]){
        
        cell.textLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:22.0];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        cell.detailTextLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:14.0];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:0.25f];
        
        UIView *darkerColor = [[UIView alloc] init];
        darkerColor.backgroundColor = [UIColor colorWithWhite:0.25f alpha:0.4];
        cell.selectedBackgroundView = darkerColor;
        
        
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor whiteColor]];


    }
    
    else {
        
        cell.textLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:24.0];
        cell.textLabel.textColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
        
        cell.detailTextLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:14.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
        
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *darkerColor = [[UIView alloc] init];
        darkerColor.backgroundColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.52f alpha:0.4];
        cell.selectedBackgroundView = darkerColor;
        
        
        cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0]];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        PFObject *removableObject=self.objects[indexPath.row];
        PFACL *postACL = [PFACL ACLWithUser:[PFUser currentUser]];
        [postACL setWriteAccess:YES forUser:[PFUser currentUser]];
        removableObject.ACL=postACL;
        
        [removableObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(!error){

                [self loadObjects];
                
            }
        }];
        
        
        
    }
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    LBSFHInboxDetailViewController *detailView = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"InboxDetailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        
        detailView.inbox= self.objects[indexPath.row];

       }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;

    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-320.jpg"]]];
    self.tableView.separatorColor = [UIColor clearColor];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadObjects];
}

//-(void) viewDidAppear:(BOOL)animated{
  //  [self.tableView reloadData];
    //NSLog(@" MPIKES?");

//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)turnBack:(id)sender {
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
                
                NSLog(@"%d", unreadMessages);
                [[NSUserDefaults standardUserDefaults] setInteger:unreadMessages forKey:@"Messages"];
                [[NSUserDefaults standardUserDefaults] synchronize];        }
            else
            {
                
            }
        }];
        
        NSLog(@"meta to query");
    }

    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
