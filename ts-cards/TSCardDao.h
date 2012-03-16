//
//  TSCardDao.h
//  ts-cards
//
//  Created by mebusw on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDao.h"
@interface TSCardDao : BaseDao


-(NSArray*)selectByNumber: (int)number;
-(NSArray*)selectByTitle: (NSString*)title;
@end
