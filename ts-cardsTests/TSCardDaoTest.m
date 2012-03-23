//
//  TSCardDaoTest.m
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TSCardDaoTest.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "TSCard.h"
#import "TSCardDao.h"


@implementation TSCardDaoTest

-(void) testSelectByNumber {
   
    TSCardDao *dao = [[TSCardDao alloc] init];
    TSCard *card = (TSCard*)[[dao selectByNumber:25] objectAtIndex:0];
    NSLog(@"%@, %@", card.title, card.asia);
    STAssertEqualStr(@"25", card.number, @"");
    STAssertNil(card.asia, @"");

}

-(void) testSelectByTitle {
   
    TSCardDao *dao = [[TSCardDao alloc] init];
    TSCard *card = (TSCard*)[[dao selectByTitle:@"007"] objectAtIndex:0];
    NSLog(@"%@, %@, %@", card.title, card.asia, card.disposable);
    STAssertEqualStr(@"89", card.number, @"");
    STAssertNotNil(card.asia, @"");    
}
@end
