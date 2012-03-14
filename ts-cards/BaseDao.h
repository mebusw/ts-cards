//
//  BaseDao.h
//  agot-ios
//
//  Created by mebusw on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@class FMDatabase;

@interface BaseDao : NSObject {
    FMDatabase *db;
}

@property (nonatomic, strong) FMDatabase *db;


@end