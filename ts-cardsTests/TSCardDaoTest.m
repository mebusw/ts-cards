//
//  TSCardDaoTest.m
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TSCardDaoTest.h"
#import "AppDelegate.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "TSCard.h"
#import "TSCardDao.h"


@implementation TSCardDaoTest

-(void) testSelectByNumber {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"db=%@", appDelegate.db);
    
    TSCardDao *dao = [[TSCardDao alloc] init];
    TSCard *card = (TSCard*)[[dao selectByNumber:25] objectAtIndex:0];
    NSLog(@"%@, %@, %@", card.title, card.asia, card.disposable);
    STAssertEquals(25, card.number, @"");
    STAssertNil(card.asia, @"");
    STAssertEqualStr(@"1", card.disposable, @"");

}

-(void) testSelectByTitle {
   
    TSCardDao *dao = [[TSCardDao alloc] init];
    TSCard *card = (TSCard*)[[dao selectByTitle:@"007"] objectAtIndex:0];
    NSLog(@"%@, %@, %@", card.title, card.asia, card.disposable);
    STAssertEquals(89, card.number, @"");
    STAssertNotNil(card.asia, @"");
    STAssertEqualStr(@"1", card.disposable, @"");
    
}
@end
