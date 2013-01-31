//
//  MIMatching.h
//  MatchIt
//
//  Created by Bill on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MIPositionConvert.h"
#import "MIBlockManager.h"
#import "MIConfig.h"

@interface MIMatching : NSObject

+(BOOL)isMatchingAWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager *)manager;

+(BOOL)isMatchingBWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager;
+(BOOL)isMatchingBWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager *)manager HorizontalFlip:(BOOL)flip;

+(BOOL)isMatchingCWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager;

+(BOOL)isMatchingDWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager;

//在算法部分没有完成之前,用这个方法把算法走过的方块标记出来,用来调试算法
+(void)markBlockWithNumber:(int)number position:(struct MIPosition)position Manager:(MIBlockManager*)manager HorizontalFlip:(BOOL)flip;

@end
