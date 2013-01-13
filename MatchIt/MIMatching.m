//
//  MIMatching.m
//  MatchIt
//
//  Created by Bill on 13-1-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "MIMatching.h"

#import "MIBlock.h"

@implementation MIMatching

+(BOOL)isAbleAWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB{
    NSLog(@"A.x=%i,A.y=%i",blockA.x,blockA.y);
    NSLog(@"B.x=%i,B.y=%i",blockB.x,blockB.y);
    if(blockA.y==blockB.y && blockA.x!=blockB.x){
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isMatchingAWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager *)manager{
    if([self isAbleAWithA:blockA B:blockB]){
        if(blockA.x>blockB.x){
            struct MIPosition positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        int count=0;
        for(int i=blockA.x+1;i<blockB.x;i++){
            //此为判断部分替代品
            count++;
            [[manager blockAtX:i Y:blockA.y]setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",count]];
        }
        return YES;
    }else{
        return NO;
    }
}


+(BOOL)isAbleBWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB{
    if((blockA.x<blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<blockB.y)){
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isMatchingBWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager *)manager{
    if([self isAbleBWithA:blockA B:blockB]){
        if(blockA.x>blockB.x && blockA.y<blockB.y){
            struct MIPosition positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        //先右后下
        int count=0;
        for(int i=blockA.x+1;i<blockB.x+1;i++){
            //此为判断部分替代品
            count++;
            [[manager blockAtX:i Y:blockA.y]setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",count]];
        }
        count=0;
        for(int i=blockA.y-1;i>blockB.y;i--){
            //此为判断部分替代品
            count++;
            [[manager blockAtX:blockB.x Y:i]setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",count]];
        }
        
        //先下后右
        count=0;
        for(int i=blockA.y-1;i>blockB.y-1;i--){
            //此为判断部分替代品
            count++;
            [[manager blockAtX:blockA.x Y:i]setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",count]];
        }
        count=0;
        for(int i=blockA.x+1;i<blockB.x;i++){
            //此为判断部分替代品
            count++;
            [[manager blockAtX:i Y:blockB.y]setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",count]];
        }
        
        return YES;
    }else{
        return NO;
    }
}


+(BOOL)isAbleCWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB{
    if((blockA.x<blockB.x && blockA.y>=blockB.y)||(blockA.x>blockB.x && blockA.y<=blockB.y)!=0){
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isMatchingCWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager{
    if([self isAbleCWithA:blockA B:blockB]){
        if(blockA.x>blockB.x && blockA.y<blockB.y){
            struct MIPosition positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        //上方
        int count=0;
        for(int i=blockA.y;i>blockB.y;i--){
            //此为判断部分替代品
            count++;
            [[manager blockAtX:blockB.x Y:i]setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",count]];
        }
        for(int j=blockA.y+1;j<BLOCKS_YCOUNT;j++){
            count=0;
            for(int i=blockA.x;i<=blockB.x;i++){
                //此为判断部分替代品
                count++;
                [[manager blockAtX:i Y:j]setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",count]];
            }
        }
        
        //下方
        count=0;
        for(int i=blockA.y-1;i>=blockB.y;i--){
            //此为判断部分替代品
            count++;
            [[manager blockAtX:blockA.x Y:i]setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",count]];
        }
        for(int j=blockB.y-1;j>=0;j--){
            count=0;
            for(int i=blockA.x;i<=blockB.x;i++){
                //此为判断部分替代品
                count++;
                NSLog(@"i=%i,j=%i",i,j);
                [[manager blockAtX:i Y:j]setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",count]];
            }
        }
        
        return YES;
    }else{
        return NO;
    }

}

@end
