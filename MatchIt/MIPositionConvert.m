//
//  MIPositionConvert.m
//  MatchIt
//
//  Created by Bill on 13-2-2.
//
//

#import "MIPositionConvert.h"
#import "MIConfig.h"

@implementation MIConversion
@synthesize flip;
@synthesize spin;

-(id)init{
    if(self=[super init]){
        self.flip=MIFlipNone;
        self.spin=MISpinNone;
    }
    return self;
}

+(id)conversion{
    return [[[self alloc]init]autorelease];
}

-(id)initWithFlip:(MIConversionFlip)flip_ Spin:(MIConversionSpin)spin_{
    if(self=[super init]){
        self.flip=flip_;
        self.spin=spin_;
    }
    return self;
}

+(id)conversionWithFlip:(MIConversionFlip)flip_ Spin:(MIConversionSpin)spin_{
    return [[[self alloc]initWithFlip:flip_ Spin:spin_]autorelease];
}

@end


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

-(void)setX:(int)x_ Y:(int)y_{
    self.x=x_;
    self.y=y_;
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

+(MIPosition*)convertWithConversion:(MIConversion*)conversion Position:(MIPosition*)position inverse:(BOOL)inverse{
    //头两种:对称变换,逆运算和本身运算相同
    MIPosition *position_=[MIPosition positionWithX:position.x Y:position.y];
    if(conversion.flip==MIFlipHorizontal){
        [position_ setX:-position_.x+BLOCKS_XCOUNT-1 Y:position_.y];
    }else if(conversion.flip==MIFlipVertical){
        [position_ setX:position_.x Y:-position_.y+BLOCKS_YCOUNT-1];
    }
    
    if(conversion.spin==MISpin180Degrees){
        [position_ setX:BLOCKS_XCOUNT-position_.x-1 Y:BLOCKS_YCOUNT-position_.y-1];
    }
    
    //很重要,执行90度旋转变化之前如果是逆运算，就必须将它宽和高互换.
    if(!inverse){
        if(conversion.spin==MISpinPlus90Degrees){
            [position_ setX:position_.y Y:-position_.x+BLOCKS_YCOUNT-1];
        }else if(conversion.spin==MISpinMinus90Degrees){
            [position_ setX:-position_.y+BLOCKS_YCOUNT-1 Y:position_.x];
        }
    }else{
        if(conversion.spin==MISpinPlus90Degrees){
            [position_ setX:-position_.y+BLOCKS_YCOUNT-1 Y:position_.x];
        }else if(conversion.spin==MISpinMinus90Degrees){
            [position_ setX:position_.y Y:-position_.x+BLOCKS_YCOUNT-1];
        }
    }
    return position_;
}

+(MIPosition*)convertWithConversion:(MIConversion *)conversion X:(int)x Y:(int)y inverse:(BOOL)inverse{
    return [MIPositionConvert convertWithConversion:conversion Position:[MIPosition positionWithX:x Y:y] inverse:YES];
}

+(NSMutableArray*)convertWithConversion:(MIConversion*)conversion Positions:(NSMutableArray*)positions inverse:(BOOL)inverse{
    NSMutableArray *result=[NSMutableArray array];
    for(MIPosition *position in positions){
        MIPosition *position_=[MIPositionConvert convertWithConversion:conversion Position:position inverse:inverse];
        [result addObject:position_];
    }
    return result;
}

@end
