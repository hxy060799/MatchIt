//
//  MIBlockManager.m
//  MatchIt
//
//  Created by Bill on 12-12-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MIBlockManager.h"
#import "MIPositionConvert.h"
#import "MIConfig.h"
#import "CCLayerTouch.h"
#import "MIBlockManagerDelegate.h"
#import "MIMatching.h"
#import "MIRoute.h"
#import "MIMap.h"

@implementation MIBlockManager

@synthesize blocks;
@synthesize selectedBlocks;

@synthesize map;

@synthesize delegate;

NSMutableArray *selectedSprites;

BOOL isPoping;

#pragma mark - init

-(id)init{
    if(self=[super init]){
        
        isPoping=NO;
        
        [self preloadParticleEffect];
        
        blocks=[[NSMutableArray alloc]init];
        selectedBlocks=[[NSMutableArray alloc]init];
        selectedSprites=[[NSMutableArray alloc]init];
        
        self.isTouchEnabled=YES;
        
        map=[[MIMap alloc]init];
        
        self.anchorPoint=ccp(0,0);
        self.position=ccp(0,0);
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"BasicImage.plist"];
        
        
        for(int i=0;i<BLOCKS_COUNT;i++){
            MIBlock *aBlock=[MIBlock blockWithBlockPosition:[MIPositionConvert indexToPositonWithIndex:i]];
            
            aBlock.delegate=self;
            
            [blocks addObject:aBlock];
        }
        
        for(int i=0;i<[blocks count];i++){
            MIBlock *aBlock=[blocks objectAtIndex:i];
            
            MIPosition *blockPosition=[MIPositionConvert indexToPositonWithIndex:i];
            
            [aBlock setBlockSpriteFrameWithFileName:[map imageNameAtX:blockPosition.x Y:blockPosition.y]];
            //[aBlock setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",blockPosition.y]];
            
            aBlock.blockSprite.anchorPoint=ccp(0,0);
            aBlock.blockSprite.position=ccp(BLOCKS_LEFT_X+BLOCKS_SIZE*blockPosition.x,BLOCKS_BOTTOM_Y+BLOCKS_SIZE*blockPosition.y);
            
            [self addChild:aBlock.blockSprite z:0];
            
            aBlock.blockRouteSprite.anchorPoint=ccp(0,0);
            aBlock.blockRouteSprite.position=ccp(BLOCKS_LEFT_X+BLOCKS_SIZE*blockPosition.x,BLOCKS_BOTTOM_Y+BLOCKS_SIZE*blockPosition.y);
            
            [self addChild:aBlock.blockRouteSprite z:1];
            
        }
        
    }
    return self;
}

+(id)blockManager{
    return [[[self alloc]init]autorelease];
}

#pragma mark - Blocks Management

-(MIBlock*)blockAtIndex:(int)index{
    return (MIBlock*)[blocks objectAtIndex:index];
}

-(MIBlock*)blockAtX:(int)x Y:(int)y{
    return [self blockAtIndex:[MIPositionConvert positionToIndexWithX:x y:y]];
}

-(MIBlock*)blockAtPosition:(MIPosition*)position{
    return [self blockAtIndex:[MIPositionConvert positionToIndexWithX:position.x y:position.y]];
}

-(void)removeBlockAtIndex:(int)index{
    MIPosition *position=[MIPositionConvert indexToPositonWithIndex:index];
    [map setBlockAtX:position.x Y:position.y block:0];
    [[self blockAtIndex:index] setBlockSpriteFrameWithFileName:[map imageNameWithImgId:0]];
}

#pragma mark - Memory Management

-(void)dealloc{
    [super dealloc];
    [blocks release];
    [selectedBlocks release];
    [selectedSprites release];
}

#pragma mark - CCLayerDelegate

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint touchPosition=[[CCDirector sharedDirector]convertToGL:[touch locationInView:[touch view]]];
    MIPosition *blockPosition=[MIPositionConvert screenToPositionWithX:touchPosition.x Y:touchPosition.y];
    
    if([MIPositionConvert blockISInAreaWithX:blockPosition.x Y:blockPosition.y]){
        MIBlock *block=[self blockAtX:blockPosition.x Y:blockPosition.y];
        [block blockBeingSelected];
    }else{
        if(delegate){
            [delegate traceWithString:@"Outside!"];
        }
    }
}

#pragma mark - MIBlockDelegate

-(void)blockBeingSelectedWithIndex:(int)blockIndex{
    MIBlock *block=[self blockAtIndex:blockIndex];
    MIPosition *blockPosition=block.blockPosition;
    //先判断这个方块是不是空的
    if([map blockAtX:blockPosition.x Y:blockPosition.y]!=0){
        //被选中的加入到数组,被取消选中的从数组中移除
        if(block.selected==NO){
            if(selectedBlocks.count==0){
                [selectedBlocks addObject:[NSNumber numberWithInt:blockIndex]];
                
                CCSprite *sprite=[CCSprite spriteWithSpriteFrameName:@"Selected.png"];
                sprite.anchorPoint=ccp(0,0);
                sprite.position=ccp(BLOCKS_LEFT_X+BLOCKS_SIZE*blockPosition.x,BLOCKS_BOTTOM_Y+BLOCKS_SIZE*blockPosition.y);
                [self addChild:sprite z:2];
                [selectedSprites addObject:sprite];
                
                block.selected=YES;
            }else if([selectedBlocks count]==1){
                MIBlock *blockA=[self blockAtIndex:[[selectedBlocks objectAtIndex:0]intValue]];
                MIPosition *blockPositionA=blockA.blockPosition;
                MIPosition *blockB=blockPosition;
                [self blockBeingSelectedWithIndex:[MIPositionConvert positionToIndexWithX:blockPositionA.x y:blockPositionA.y]];
                
                if([map blockAtX:blockPositionA.x Y:blockPositionA.y]==[map blockAtX:blockB.x Y:blockB.y]){
                    NSMutableDictionary *matchResult=[MIMatching isMatchingWithA:blockPositionA B:blockB Map:map];
                    if([[matchResult objectForKey:@"IsMatched"]boolValue]==YES){
                        MIRoute *route=[matchResult objectForKey:@"Route"];
                        [route parseVerteses];
                        [MIRoute drawRouteWithRoute:route manager:self];
                        
                        [self popBlockWithIndexA:[MIPositionConvert positionToIndexWithX:blockPositionA.x y:blockPositionA.y] IndexB:blockIndex];
                    }else{
                        NSLog(@"Not Matched");
                    }
                }
            }
        }else{
            for(int i=0;i<[selectedBlocks count];i++){
                NSNumber *selectedIndex=[selectedBlocks objectAtIndex:i];
                if([selectedIndex intValue]==blockIndex){
                    [selectedBlocks removeObjectAtIndex:i];
                    [[selectedSprites objectAtIndex:i]removeFromParentAndCleanup:YES];
                    [selectedSprites removeObjectAtIndex:i];
                    block.selected=NO;
                }
            }
        }
        if(delegate){
            [delegate traceWithString:[NSString stringWithFormat:@"X:%i,Y:%i,Selected:%d,All:%iSelected",blockPosition.x,blockPosition.y,block.selected,[selectedBlocks count]]];
        }
    }
}

-(void)preloadParticleEffect{
    [CCParticleSystemQuad particleWithFile:@"POPBlock.plist"];
}

-(void)popBlockWithIndexA:(int)indexA IndexB:(int)indexB{
    isPoping=YES;
    
    id delay=[CCDelayTime actionWithDuration:0.3];
    id clearRoute=[CCCallFunc actionWithTarget:self selector:@selector(clearRoute)];
    id popBlockA=[CCCallBlock actionWithBlock:^(void){[self showPOPParticleWithBlockIndex:indexA];}];
    id popBlockB=[CCCallBlock actionWithBlock:^(void){[self showPOPParticleWithBlockIndex:indexB];}];
    //[self removeBlockAtIndex:[MIPositionConvert positionToIndexWithX:blockPositionA.x y:blockPositionA.y]];
    //[self removeBlockAtIndex:blockIndex];
    
    
    [self runAction:[CCSequence actions:delay,clearRoute,popBlockA,popBlockB,nil]];
    
}

-(void)clearRoute{
    for(MIBlock *block in blocks){
        [block setBlockRouteSpriteFrameWithFileName:@"Block_None.png"];
    }
}

-(void)showPOPParticleWithBlockIndex:(int)index{
    //显示POP粒子效果的同时也移除方块
    MIPosition *blockPosition=[MIPositionConvert indexToPositonWithIndex:index];
    
    [self removeBlockAtIndex:index];
    
    CCParticleSystem *system;
    system=[CCParticleSystemQuad particleWithFile:@"POPBlock.plist"];
    system.position=ccp(BLOCKS_LEFT_X+BLOCKS_SIZE*blockPosition.x+BLOCKS_SIZE/2,BLOCKS_BOTTOM_Y+BLOCKS_SIZE*blockPosition.y+BLOCKS_SIZE/2);
    [self addChild:system z:100];
}

@end
