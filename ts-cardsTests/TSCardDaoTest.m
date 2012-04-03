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
    DLog(@"%@, %@", card.title, card.asia);
    STAssertEqualStr(@"25", card.number, @"");
    STAssertNil(card.asia, @"");

}

-(void) testSelectByInvalidNumber {
    
    TSCardDao *dao = [[TSCardDao alloc] init];
    NSArray *a = [dao selectByNumber:200];
    STAssertEquals(0U, [a count], @"");

    
}

-(void) testSelectByTitle {
   
    TSCardDao *dao = [[TSCardDao alloc] init];
    TSCard *card = (TSCard*)[[dao selectByTitle:@"007"] objectAtIndex:0];
    DLog(@"%@, %@, %@", card.title, card.asia, card.disposable);
    STAssertEqualStr(@"89", card.number, @"");
    STAssertNotNil(card.asia, @"");    
}



-(void) testSelectByTitleOrNumber {
    
    TSCardDao *dao = [[TSCardDao alloc] init];
    NSArray *a = [dao selectByTitleOrNumber:@"7"];

    TSCard *card1 = [a objectAtIndex:0];
    STAssertEqualStr(@"社会主义政府", card1.title, @"");
    TSCard *card2 = [a objectAtIndex:1];
    STAssertEqualStr(@"苏联击落 KAL-007*", card2.title, @"");
  
}

@end
