//
//  MasterViewController.h
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

#import "TSCard.h"
@interface MasterViewController : UITableViewController<UIActionSheetDelegate, SKPaymentTransactionObserver> {
    
}

@property (nonatomic, strong) NSMutableArray *_objects;
@property (nonatomic, strong) NSArray *_searchResults;

-(void) insertNewCard:(TSCard*)card;
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;


-(void) appendAllCards;
@end
