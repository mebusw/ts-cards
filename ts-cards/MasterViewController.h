//
//  MasterViewController.h
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController {
    
}

@property (nonatomic, strong) NSMutableArray *_objects;

-(void) insertNewCard:(int)number;

@end
