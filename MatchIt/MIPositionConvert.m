//
//  MIPositionConvert.m
//  MatchIt
//
//  Created by Bill on 13-2-2.
//
//

#import "MIPositionConvert.h"
#import "MIConfig.h"

@implementation MIPosition

@synthesize x;
@synthesize y;
@synthesize direction;

-(id)initWithX:(int)x_ Y:(int)y_{
    if(self=[super init]){
        self.x=x_;
        self.y=y_;
        self.direction=MIDirectionNone;
    }
    return self;
}

+(id)positionWithX:(int)x_ Y:(int)y_{
    return [[[MIPosition alloc]initWithX:x_ Y:y_]autorelease];
}

@end

@implementation MIPositionConvert

+(int)positionToIndexWithX:(int)x y:(int)y{
    return y*BLOCKS_XCOUNT+x;
}

+(MIPosition*)indexToPositonWithIndex:(int)index{
    return [MIPosition positionWithX:index%BLOCKS_XCOUNT Y:index/BLOCKS_XCOUNT];
}


+(MIPosition*)screenToPositionWithX:(float)x Y:(float)y{
    int x_=floor((x-BLOCKS_LEFT_X)/BLOCKS_SIZE);
    int y_=floor((y-BLOCKS_BOTTOM_Y)/BLOCKS_SIZE);
    
    return [MIPosition positionWithX:x_ Y:y_];
}


+(BOOL)blockISInAreaWithX:(int)x Y:(int)y{
    if(x>BLOCKS_XCOUNT-1){
        return NO;
    }
    if(x<0){
        return NO;
    }
    if(y>BLOCKS_YCOUNT-1){
        return NO;
    }
    if(y<0){
        return NO;
    }
    return YES;

}

+(MIPosition*)horizontalFlipWithPosition:(MIPosition*)position{
    return [MIPosition positionWithX:-position.x+BLOCKS_XCOUNT-1 Y:position.y];
}

+(MIPosition*)ConvertPositionWithConversion:(MIConversion)conversion Position:(MIPosition*)position inverse:(BOOL)inverse{
    //头两种:对称变换,逆运算和本身运算相同
    if(conversion==MIConversionHorizontalFlip){
        return [MIPosition positionWithX:-position.x+BLOCKS_XCOUNT-1 Y:position.y];
    }else if(conversion==MIConversionVerticalFlip){
        return [MIPosition positionWithX:position.x Y:-position.y+BLOCKS_YCOUNT-1];
    }
    
    if(conversion==MIConversionPlus180Degrees){
        return [MIPosition positionWithX:BLOCKS_XCOUNT-position.x-1 Y:BLOCKS_YCOUNT-position.y-1];
    }
    
    //很重要,执行90度旋转变化之前如果是逆运算，就必须将它宽和高互换.
    int widthTemp=BLOCKS_XCOUNT;
    int heightTemp=BLOCKS_YCOUNT;
    if(inverse){
        widthTemp=BLOCKS_YCOUNT;
        heightTemp=BLOCKS_XCOUNT;
    }
    
    if(conversion==MIConversionPlus90Degrees){
        return [MIPosition positionWithX:-position.y+heightTemp-1 Y:position.x];
    }else if(conversion==MIConversionMinus90Degrees){
        return [MIPosition positionWithX:position.y Y:-position.x+heightTemp-1];
    }
    
    return [MIPosition positionWithX:position.x Y:position.y];
}

@end
