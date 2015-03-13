//
//  LBSFHMenuProductDetailViewController.h
//  Hotel Services
//
//  Created by Mr John Platsis on 30/07/2014.
//  Copyright (c) 2014 Mr John Platsis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JSCustomBadge.h"

@interface LBSFHMenuProductDetailViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *staticDescription;
@property (weak, nonatomic) IBOutlet UILabel *staticSpecialInstruction;
@property (weak, nonatomic) IBOutlet UILabel *staticQty;
@property (strong, nonatomic) IBOutlet PFImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UITextView *productDescription;
@property (weak, nonatomic) IBOutlet UITextField *specialInstructions;
@property (weak, nonatomic) IBOutlet UIButton *addToCart;
@property (weak, nonatomic) IBOutlet UIPickerView *qtyPicker;
@property (strong, nonatomic) NSArray *pickerTitles;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) PFObject* product;
@property NSInteger pickerSelection;
@property CGPoint originalCenter;
@property (nonatomic) NSMutableArray *cart;
@property (strong, nonatomic) NSString *key;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *inboxButton;
@property (nonatomic) NSTimer *msgTimer;
@property (nonatomic) JSCustomBadge* inboxBadge;


@end
