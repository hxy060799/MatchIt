//
//  MIBlockManager.h
//  MatchIt
//
//  Created by Bill on 12-12-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCLayerTouchDelegate.h"
#import "MIBlockDelegate.h"
#import "MIBlock.h"

@class CCLayerTouch;
@class MIBlock;

@protocol MIBlockManagerDelegate;

@interface MIBlockManager : NSObject<CCLayerTouchDelegate,MIBlockDelegate>{
    NSMutableArray *blocks;
    
    CCLayerTouch *blocksLayer;
    
    NSMutableArray *selectedBlocks;
    
    //T
    id<MIBlockManagerDelegate>delegate;
}

@property(retain,nonatomic)NSMutableArray *blocks;

@property(retain,nonatomic)CCLayerTouch *blocksLayer;

@property(retain,nonatomic)NSMutableArray *selectedBlocks;

@property(retain,nonatomic)id<MIBlockManagerDelegate>delegate;


-(id)init;
+(id)blockManager;

-(MIBlock*)blockAtIndex:(int)index;
-(MIBlock*)blockAtX:(int)x Y:(int)y;

@end
