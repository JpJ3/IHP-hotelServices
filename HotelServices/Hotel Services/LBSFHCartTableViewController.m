//
//  LBSFHCartTableViewController.m
//  Hotel Services
//
//  Created by Mr John Platsis on 04/08/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import "LBSFHCartTableViewController.h"
#import "LBSFHCartTableViewCell.h"

@interface LBSFHCartTableViewController ()

@end

@implementation LBSFHCartTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.inboxButton.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    self.clearButton.tintColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];

    
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background-320.jpg"]]];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    
    NSArray *cart = [[[NSUserDefaults standardUserDefaults] objectForKey:self.key] mutableCopy];
    
    if(cart == nil){
        
        self.cart= [[NSMutableArray alloc]init];
        NSLog(@" STO CART NIL EIMAI");
    }
    else {
        self.cart = [cart mutableCopy];
        NSLog(@" STO  CART MUTABLECOPY EIMAI");
    }
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.cart count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBSFHCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartCell" forIndexPath:indexPath];
    
    
    NSDictionary *cartObject = self.cart[indexPath.row];
    
    //NSLog(@" STO CART ccellforrow EIMAI %@", cartObject);
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:100];
    nameLabel.text = [cartObject objectForKey:@"name"];
    nameLabel.font =[UIFont fontWithName:@"Baskerville-BoldItalic" size:24.0];
    nameLabel.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    
    NSNumber *productPrice =[cartObject objectForKey:@"productPrice"];
    NSNumber *qty=[cartObject objectForKey:@"QTY"];
    float displayablePrice= [productPrice floatValue] * [qty floatValue];
    
    UILabel *priceLabel = (UILabel*) [cell viewWithTag:101];
    priceLabel.text = [NSString stringWithFormat:@"Price: %.2f", displayablePrice];
    priceLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:16.0];
    priceLabel.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    UILabel *QtyLabel = (UILabel*) [cell viewWithTag:102];
    QtyLabel.text = [NSString stringWithFormat:@"Qty: %@", qty];
    QtyLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:16.0];
    QtyLabel.textColor=[UIColor colorWithRed:1.0 green:0.16f blue:0.42f alpha:1.0];
    
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *darkerColor = [[UIView alloc] init];
    darkerColor.backgroundColor = [UIColor colorWithRed:1.0 green:0.16f blue:0.52f alpha:0.4];
    cell.selectedBackgroundView = darkerColor;

    cell.increaseQty.tag=indexPath.row;
    cell.decreaseQty.tag=indexPath.row;
    
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        NSMutableDictionary *item = [self.cart objectAtIndex:indexPath.row];

        [self.cart removeObject:item];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.cart forKey:self.key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.tableView reloadData];


    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - alertview delegate


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    NSLog(@" eimai mesa sto delegate %@", self.cart);

    
    if([title isEqualToString:@"Yes"])
    {
        
        NSLog(@" eimai mesa sto Yes %@", self.cart);

        [self.cart removeAllObjects];
        [[NSUserDefaults standardUserDefaults] setObject:self.cart forKey:self.key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.tableView reloadData];
    }
    else if ([title isEqualToString:@"Checkout"]) {
        
        NSString *message;
        message = [NSString stringWithFormat:@"I am user %@, and I would like to order: \n", [[PFUser currentUser] objectForKey:@"username"]];
        
        for (NSDictionary *cartItem in self.cart){
            NSNumber *qty =[cartItem objectForKey:@"QTY"];
            
            NSString *temp1=  [NSString stringWithFormat:@" %@ item(s) of the product: ", qty];
            NSString *name=[cartItem objectForKey:@"name"];
            NSString *temp2 = [temp1 stringByAppendingString:name];
            NSString *temp3 = [temp2 stringByAppendingString:@"\n\n"];
            temp3 = [temp3 stringByAppendingString:@"Special Instructions: \n"];
            temp3 = [temp3 stringByAppendingString:[cartItem objectForKey:@"specialInstructions"]];
            temp3 = [temp3 stringByAppendingString:@"\n\n"];

            
            message= [message stringByAppendingString:temp3];
            
        }
        
        message= [message stringByAppendingString:@"please, thank you"];
        
        PFObject *order = [PFObject objectWithClassName:@"Orders"];
        order[@"title"]= @"room service order";
        order[@"message"] = message;
        order[@"completed"] = [NSNumber numberWithBool:NO];
        order[@"sender"] = [[PFUser currentUser] objectId];
        [order saveInBackground];

        [[[UIAlertView alloc] initWithTitle:@"Order Sent"
                                    message:@"Your Order is now being sent"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
        
        [self.cart removeAllObjects];
        [[NSUserDefaults standardUserDefaults] setObject:self.cart forKey:self.key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.tableView reloadData];

        
    }
}


#pragma mark - Helper Methods


- (IBAction)increaseQuantity:(UIButton *)sender {
    
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *) self.cart[sender.tag]];
    //NSMutableDictionary *removableObject = item;

    
    NSNumber *qty=[item objectForKey:@"QTY"];
    
    int changedQty = [qty intValue];
    changedQty++;
    //[self.cart[sender.tag] setObject:[NSNumber numberWithInteger:changedQty] forKey:@"QTY"];
    
    NSUInteger index = [self.cart indexOfObjectPassingTest:
                        ^BOOL(NSDictionary *dict, NSUInteger idx, BOOL *stop)
                        {
                            return [[dict objectForKey:@"name"] isEqual:[item objectForKey:@"name"]];
                        }
                        ];

    [item setObject:[NSNumber numberWithInteger:changedQty] forKey:@"QTY"];
    [self.cart removeObject:self.cart[sender.tag]];
    [self.cart insertObject:item atIndex:index];
    [[NSUserDefaults standardUserDefaults] setObject:self.cart forKey:self.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];

    
    
}

- (IBAction)decreaseQuantity:(UIButton *)sender {
    
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *) self.cart[sender.tag]];
    //NSMutableDictionary *removableObject = item;
    
    
    NSNumber *qty=[item objectForKey:@"QTY"];
    
    int changedQty = [qty intValue];
    changedQty--;
    if (changedQty==0){

        [self.cart removeObject:self.cart[sender.tag]];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.cart forKey:self.key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.tableView reloadData];
        
    }
    else {

        NSUInteger index = [self.cart indexOfObjectPassingTest:
                            ^BOOL(NSDictionary *dict, NSUInteger idx, BOOL *stop)
                            {
                                return [[dict objectForKey:@"name"] isEqual:[item objectForKey:@"name"]];
                            }
                            ];
        [item setObject:[NSNumber numberWithInteger:changedQty] forKey:@"QTY"];
        //[self.cart[sender.tag] setObject:[NSNumber numberWithInteger:changedQty] forKey:@"QTY"];
        [self.cart removeObject:self.cart[sender.tag]];
        [self.cart insertObject:item atIndex:index];
        [[NSUserDefaults standardUserDefaults] setObject:self.cart forKey:self.key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.tableView reloadData];
    }


}

- (IBAction)clearCartButton:(id)sender {
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Clear Cart"
                                                      message:@"Are you sure you want to empty your cart?"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Yes", nil];
    [message show];
}
- (IBAction)checkout:(id)sender {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Checkout"
                                                      message:@"Are you sure you want to checkout?"
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Checkout", nil];
    [alert show];

    
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

@end
