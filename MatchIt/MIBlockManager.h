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
@class MIMap;

@protocol MIBlockManagerDelegate;

@interface MIBlockManager : CCLayer <CCLayerTouchDelegate,MIBlockDelegate,UIAlertViewDelegate>{
    NSMutableArray *blocks;
    
    NSMutableArray *selectedBlocks;
    
    MIMap *map;
    
    //T
    id<MIBlockManagerDelegate>delegate;
}

@property(retain,nonatomic)NSMutableArray *blocks;

@property(retain,nonatomic)NSMutableArray *selectedBlocks;

@property(retain,nonatomic)MIMap *map;

@property(retain,nonatomic)id<MIBlockManagerDelegate>delegate;


-(id)init;
+(id)blockManager;
-(void)startGame;

-(MIBlock*)blockAtIndex:(int)index;
-(MIBlock*)blockAtX:(int)x Y:(int)y;

@end
