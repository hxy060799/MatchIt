//
//  MIBlock.h
//  MatchIt
//
//  Created by Bill on 12-12-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "MIPositionConvert.h"

//游戏的基础-单个方块

@protocol MIBlockDelegate;

@interface MIBlock : NSObject{
    CCSprite *blockSprite;
    CCSprite *blockSelectedSprite;
    
    BOOL selected;
    
    MIPosition *blockPosition;
    
    id<MIBlockDelegate>delegate;
}

@property(retain,nonatomic)CCSprite *blockSprite;
@property(retain,nonatomic)CCSprite *blockRouteSprite;

@property(assign,nonatomic)BOOL selected;

@property(readonly,nonatomic)MIPosition *blockPosition;

@property(retain,nonatomic)id<MIBlockDelegate>delegate;

-(id)init;
+(id)block;

-(id)initWithSpriteFrameName:(NSString*)spriteFrameName;
+(id)blockWithSpriteFrameName:(NSString*)spriteFrameName;

-(id)initWithBlockPosition:(MIPosition*)position_;
+(id)blockWithBlockPosition:(MIPosition*)position_;


-(void)setBlockSpriteFrameWithFileName:(NSString*)spriteFrameName;
-(void)setBlockRouteSpriteFrameWithFileName:(NSString*)spriteFrameName;


-(void)blockBeingSelected;

@end
