//
//  MIBlock.m
//  MatchIt
//
//  Created by Bill on 12-12-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MIBlock.h"
#import "MIBlockDelegate.h"
#import "MIConfig.h"

@implementation MIBlock

@synthesize blockSprite;
@synthesize blockRouteSprite;
@synthesize selected;
@synthesize delegate;
@synthesize blockPosition;

#pragma mark - init

-(id)init{
    if(self=[super init]){
        blockSprite=[[[CCSprite alloc]init]autorelease];
        blockRouteSprite=[[[CCSprite alloc]init]autorelease];
        self.selected=NO;
        blockPosition=[[MIPosition alloc]initWithX:-1 Y:-1];
    }
    return self;
}

+(id)block{
    return [[[self alloc] init]autorelease];
}

-(id)initWithSpriteFrameName:(NSString*)spriteFrameName{
    if(self=[self init]){
        blockSprite=[[[CCSprite alloc]initWithSpriteFrameName:spriteFrameName]autorelease];
        [blockSprite setScale:BLOCKS_SIZE/BLOCKS_IMAGE_SIZE];
    }
    return self;
}

+(id)blockWithSpriteFrameName:(NSString*)spriteFrameName{
    return [[[self alloc]initWithSpriteFrameName:spriteFrameName]autorelease];
}

-(id)initWithBlockPosition:(MIPosition*)position_{
    if(self=[self init]){
        [blockPosition setX:position_.x Y:position_.y];
    }
    return self;
}

+(id)blockWithBlockPosition:(MIPosition*)position_{
    return [[[self alloc]initWithBlockPosition:position_]autorelease];
}

#pragma mark - Blocks Management

-(void)setBlockSpriteFrameWithFileName:(NSString*)spriteFrameName{
    [blockSprite setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:spriteFrameName]];
    [blockSprite setScale:BLOCKS_SIZE/BLOCKS_IMAGE_SIZE];
}

-(void)setBlockRouteSpriteFrameWithFileName:(NSString*)spriteFrameName{
    [blockRouteSprite setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache]spriteFrameByName:spriteFrameName]];
    [blockRouteSprite setScale:BLOCKS_SIZE/BLOCKS_IMAGE_SIZE];
}


-(void)blockBeingSelected{
    if(delegate){
        [delegate blockBeingSelectedWithIndex:[MIPositionConvert positionToIndexWithX:blockPosition.x y:blockPosition.y]];
    }
}

#pragma mark - Memory Management

-(void)dealloc{
    [delegate release];
    [blockPosition release];
    [super dealloc];
}

@end
