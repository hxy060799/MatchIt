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

+(BOOL)isMatchingAWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager *)manager{
    //第一种直线方案不进行坐标转换,直接把另外一种方案放到里面.
    if(blockA.y==blockB.y){
        //横着
        if(blockA.x>blockB.x){
            struct MIPosition positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        int count=0;
        for(int i=blockA.x+1;i<blockB.x;i++){
            //此为判断部分替代品
            count++;
            [self markBlockWithNumber:count position:MIPositionMake(i, blockA.y) Manager:manager HorizontalFlip:NO];
        }
        return YES;
    }else if(blockA.x==blockB.x){
        //竖着
        if(blockA.y>blockB.y){
            struct MIPosition positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        int count=0;
        for(int i=blockA.y+1;i<blockB.y;i++){
            //此为判断部分替代品
            count++;
            [self markBlockWithNumber:count position:MIPositionMake(blockA.x, i) Manager:manager HorizontalFlip:NO];
        }
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isMatchingBWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager *)manager{
    if([self isMatchingBWithA:blockA B:blockB Manager:manager HorizontalFlip:NO]==YES){
        return YES;
    }else if([self isMatchingBWithA:blockA B:blockB Manager:manager HorizontalFlip:YES]==YES){
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isMatchingBWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager *)manager HorizontalFlip:(BOOL)flip{
    if(flip==YES){
        blockA=MIHorizontalFlip(blockA);
        blockB=MIHorizontalFlip(blockB);
    }
    
    if((blockA.x<blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<blockB.y)){
        //方块A在左上
        if(blockA.x>blockB.x && blockA.y<blockB.y){
            struct MIPosition positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        //先右后下
        int count=0;
        for(int i=blockA.x+1;i<=blockB.x;i++){
            //此为判断部分替代品
            count++;
            [self markBlockWithNumber:count position:MIPositionMake(i, blockA.y) Manager:manager HorizontalFlip:flip];
        }
        count=0;
        for(int i=blockA.y-1;i>blockB.y;i--){
            //此为判断部分替代品
            count++;
            [self markBlockWithNumber:count position:MIPositionMake(blockB.x, i) Manager:manager HorizontalFlip:flip];
        }
        
        //先下后右
        count=0;
        for(int i=blockA.y-1;i>=blockB.y;i--){
            //此为判断部分替代品
            count++;
            [self markBlockWithNumber:count position:MIPositionMake(blockA.x, i) Manager:manager HorizontalFlip:flip];
        }
        count=0;
        for(int i=blockA.x+1;i<blockB.x;i++){
            //此为判断部分替代品
            count++;
            [self markBlockWithNumber:count position:MIPositionMake(i, blockB.y) Manager:manager HorizontalFlip:flip];
        }
        
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isMatchingCWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager{
    if([self isMatchingCWithA:blockA B:blockB Manager:manager HorizontalFlip:NO]){
        return YES;
    }else if([self isMatchingCWithA:blockA B:blockB Manager:manager HorizontalFlip:YES]){
        return YES;
    }else{
        return NO;
    }
}


+(BOOL)isMatchingCWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager *)manager HorizontalFlip:(BOOL)flip{
    if(flip==YES){
        blockA=MIHorizontalFlip(blockA);
        blockB=MIHorizontalFlip(blockB);
    }
    
    if((blockA.x<blockB.x && blockA.y>=blockB.y)||(blockA.x>blockB.x && blockA.y<=blockB.y)){
        if(blockA.x>blockB.x && blockA.y<blockB.y){
            struct MIPosition positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        //上方
        if(blockA.y<BLOCKS_YCOUNT-1){
            int count=0;
            //公共部分
            for(int i=blockA.y;i>blockB.y;i--){
                //此为判断部分替代品
                count++;
                [self markBlockWithNumber:count position:MIPositionMake(blockB.x, i) Manager:manager HorizontalFlip:flip];
            }
            for(int j=blockA.y+1;j<BLOCKS_YCOUNT;j++){
                //左右两边
                count=0;
                for(int i=blockA.y+1;i<=j;i++){
                    //此为判断部分替代品
                    count++;
                    [self markBlockWithNumber:count position:MIPositionMake(blockA.x, i) Manager:manager HorizontalFlip:flip];
                    [self markBlockWithNumber:count position:MIPositionMake(blockB.x, i) Manager:manager HorizontalFlip:flip];
                }
                //上面
                count=0;
                for(int i=blockA.x+1;i<blockB.x;i++){
                    //此为判断部分替代品
                    count++;
                    [self markBlockWithNumber:count position:MIPositionMake(i, j) Manager:manager HorizontalFlip:flip];
                }
            }
        }
        
        //下方
        if(blockB.y>0){
            int count=0;
            //公共部分
            for(int i=blockA.y-1;i>=blockB.y;i--){
                //此为判断部分替代品
                count++;
                [self markBlockWithNumber:count position:MIPositionMake(blockA.x, i) Manager:manager HorizontalFlip:flip];
            }
            for(int j=blockB.y-1;j>=0;j--){
                //左右两边
                count=0;
                for(int i=j;i<=blockB.y-1;i++){
                    //此为判断部分替代品
                    count++;
                    [self markBlockWithNumber:count position:MIPositionMake(blockA.x, i) Manager:manager HorizontalFlip:flip];
                    [self markBlockWithNumber:count position:MIPositionMake(blockB.x, i) Manager:manager HorizontalFlip:flip];
                }
                //下面
                count=0;
                for(int i=blockA.x+1;i<blockB.x;i++){
                    //此为判断部分替代品
                    count++;
                    [self markBlockWithNumber:count position:MIPositionMake(i, j) Manager:manager HorizontalFlip:flip];
                }
            }
        }
        
        //左方
        if(blockA.x>0){
            int count=0;
            //公共部分
            for(int i=blockA.x;i<blockB.x;i++){
                //此为判断部分替代品
                count++;
                [self markBlockWithNumber:count position:MIPositionMake(i, blockB.y) Manager:manager HorizontalFlip:flip];
            }
            
            for(int j=blockA.x-1;j>=0;j--){
                //上下两边
                count=0;
                for(int i=j;i<=blockA.x-1;i++){
                    //此为判断部分替代品
                    count++;
                    [self markBlockWithNumber:count position:MIPositionMake(i, blockA.y) Manager:manager HorizontalFlip:flip];
                    [self markBlockWithNumber:count position:MIPositionMake(i, blockB.y) Manager:manager HorizontalFlip:flip];
                }
                
                //左面
                count=0;
                for(int i=blockA.y-1;i>blockB.y;i--){
                    //此为判断部分替代品
                    count++;
                    [self markBlockWithNumber:count position:MIPositionMake(j, i) Manager:manager HorizontalFlip:flip];
                }
                
            }
            
        }
        
        //右方
        if(blockB.x<BLOCKS_XCOUNT-1){
            int count=0;
            //公共部分
            for(int i=blockA.x+1;i<=blockB.x;i++){
                //此为判断部分替代品
                count++;
                [self markBlockWithNumber:count position:MIPositionMake(i, blockA.y) Manager:manager HorizontalFlip:flip];
            }
            
            for(int j=blockB.x+1;j<BLOCKS_XCOUNT;j++){
                //上下两边
                count=0;
                for(int i=blockB.x+1;i<=j;i++){
                    //此为判断部分替代品
                    count++;
                    [self markBlockWithNumber:count position:MIPositionMake(i, blockA.y) Manager:manager HorizontalFlip:flip];
                    [self markBlockWithNumber:count position:MIPositionMake(i, blockB.y) Manager:manager HorizontalFlip:flip];
                }
                
                //右面
                count=0;
                for(int i=blockA.y-1;i>blockB.y;i--){
                    //此为判断部分替代品
                    count++;
                    [self markBlockWithNumber:count position:MIPositionMake(j, i) Manager:manager HorizontalFlip:flip];
                }
                
            }
            
        }
        return YES;
    }else{
        return NO;
    }
    
}


+(BOOL)isMatchingDWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager*)manager{
    if([self isMatchingDWithA:blockA B:blockB Manager:manager HorizontalFlip:NO]){
        return YES;
    }else if([self isMatchingDWithA:blockA B:blockB Manager:manager HorizontalFlip:YES]){
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isMatchingDWithA:(struct MIPosition)blockA B:(struct MIPosition)blockB Manager:(MIBlockManager *)manager HorizontalFlip:(BOOL)flip{
    if(flip==YES){
        blockA=MIHorizontalFlip(blockA);
        blockB=MIHorizontalFlip(blockB);
    }
    
    if(((blockA.x<blockB.x && blockA.y>blockB.y)||(blockA.x>blockB.x && blockA.y<blockB.y))&&(abs(blockA.y-blockB.y)>1)){
        if(blockA.x>blockB.x && blockA.y<blockB.y){
            struct MIPosition positionTemp=blockB;
            blockB=blockA;
            blockA=positionTemp;
        }
        
        for(int i=blockA.x+1;i<blockB.x;i++){
            int count=0;
            //上段
            for(int j=blockA.x+1;j<=i;j++){
                //此为判断部分替代品
                count++;
                [self markBlockWithNumber:count position:MIPositionMake(j, blockA.y) Manager:manager HorizontalFlip:flip];
            }
            count=0;
            
            //中间
            for(int j=blockA.y-1;j>blockB.y;j--){
                //此为判断部分替代品
                count++;
                [self markBlockWithNumber:count position:MIPositionMake(i, j) Manager:manager HorizontalFlip:flip];
            }
            count=0;
            //下段
            for(int j=i;j<blockB.x;j++){
                //此为判断部分替代品
                count++;
                [self markBlockWithNumber:count position:MIPositionMake(j, blockB.y) Manager:manager HorizontalFlip:flip];
            }
        }
        
        for(int i=blockA.y-1;i>blockB.y;i--){
            int count=0;
            //左段
            for(int j=blockA.y-1;j>=i;j--){
                count++;
                [self markBlockWithNumber:count position:MIPositionMake(blockA.x, j) Manager:manager HorizontalFlip:flip];
            }
            count=0;
            //中间
            for(int j=blockA.x+1;j<blockB.x;j++){
                count++;
                [self markBlockWithNumber:count position:MIPositionMake(j, i) Manager:manager HorizontalFlip:flip];
            }
            //右段
            count=0;
            for(int j=i;j>blockB.y;j--){
                count++;
                [self markBlockWithNumber:count position:MIPositionMake(blockB.x, j) Manager:manager HorizontalFlip:flip];
            }
        }
        
        return YES;
    }else{
        return NO;
    }
}

+(void)markBlockWithNumber:(int)number position:(struct MIPosition)position Manager:(MIBlockManager*)manager HorizontalFlip:(BOOL)flip{
    struct MIPosition blockTemp=flip?MIHorizontalFlip(MIPositionMake(position.x, position.y)):MIPositionMake(position.x, position.y);
    [[manager blockAtX:blockTemp.x Y:blockTemp.y]setBlockSpriteFrameWithFileName:[NSString stringWithFormat:@"Block_%i.png",number]];
}

@end
