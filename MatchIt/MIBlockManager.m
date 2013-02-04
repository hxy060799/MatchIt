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
@synthesize blocksLayer;
@synthesize selectedBlocks;

@synthesize map;

@synthesize delegate;

#pragma mark - init

-(id)init{
    if(self=[super init]){
        
        blocks=[[NSMutableArray alloc]init];
        selectedBlocks=[[NSMutableArray alloc]init];
        blocksLayer=[[[CCLayerTouch alloc]init]autorelease];
        
        blocksLayer.isTouchEnabled=YES;
        blocksLayer.delegete=self;
        
        map=[[MIMap alloc]init];
        
        self.blocksLayer.anchorPoint=ccp(0,0);
        self.blocksLayer.position=ccp(0,0);
        
        
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
            
            [blocksLayer addChild:aBlock.blockSprite z:0];
            
            aBlock.blockRouteSprite.anchorPoint=ccp(0,0);
            aBlock.blockRouteSprite.position=ccp(BLOCKS_LEFT_X+BLOCKS_SIZE*blockPosition.x,BLOCKS_BOTTOM_Y+BLOCKS_SIZE*blockPosition.y);
            
            [blocksLayer addChild:aBlock.blockRouteSprite z:1];
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

#pragma mark - Memory Management

-(void)dealloc{
    [super dealloc];
    [blocks release];
    [selectedBlocks release];
}

#pragma mark - CCLayerTouchDelegate

-(void)ccLayerTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
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

-(void)blockBeingSelected:(MIBlock *)block Index:(int)blockIndex NowSelected:(BOOL)selected{
    MIPosition *blockPosition=[MIPositionConvert indexToPositonWithIndex:blockIndex];
    //先判断这个方块是不是空的
    if([map blockAtX:blockPosition.x Y:blockPosition.y]!=0){
        //被选中的加入到数组,被取消选中的从数组中移除
        if(selected==YES){
            [block setBlockSpriteFrameWithFileName:@"Block_Blue.png"];
            [selectedBlocks addObject:[NSNumber numberWithInt:blockIndex]];
            
            if([selectedBlocks count]==2){
                /*NSMutableArray *array=[NSMutableArray array];
                for(int i=0;i<[selectedBlocks count];i++){
                    MIPosition *position=[self blockAtIndex:[[selectedBlocks objectAtIndex:i]intValue]].blockPosition;
                    [array addObject:position];
                }*/
                
                MIPosition *blockA=[self blockAtIndex:[[selectedBlocks objectAtIndex:0]intValue]].blockPosition;
                MIPosition *blockB=[self blockAtIndex:[[selectedBlocks objectAtIndex:1]intValue]].blockPosition;
                
                NSMutableDictionary *matchResult=[MIMatching isMatchingDWithA:blockA B:blockB Map:map];
                if([[matchResult objectForKey:@"IsMatched"]boolValue]==YES){
                     MIRoute *route=[matchResult objectForKey:@"Route"];
                    [route parseVerteses];
                    [MIRoute drawRouteWithRoute:route manager:self];
                }else{
                    NSLog(@"Not Matched");
                }

                
            }
            
            /*
             if([selectedBlocks count]==2){
             MIPosition *blockA=[self blockAtIndex:[[selectedBlocks objectAtIndex:0]intValue]].blockPosition;
             MIPosition *blockB=[self blockAtIndex:[[selectedBlocks objectAtIndex:1]intValue]].blockPosition;
             NSLog(@"%i",[MIMatching isMatchingAWithA:blockA B:blockB Manager:self]);
             }
             */
            
        }else{
            [block setBlockSpriteFrameWithFileName:@"Block_Red.png"];
            for(int i=0;i<[selectedBlocks count];i++){
                NSNumber *selectedIndex=[selectedBlocks objectAtIndex:i];
                if([selectedIndex intValue]==blockIndex){
                    [selectedBlocks removeObject:selectedIndex];
                }
            }
        }
        if(delegate){
            [delegate traceWithString:[NSString stringWithFormat:@"X:%i,Y:%i,Selected:%d,All:%iSelected",blockPosition.x,blockPosition.y,selected,[selectedBlocks count]]];
        }
    }
}

@end
