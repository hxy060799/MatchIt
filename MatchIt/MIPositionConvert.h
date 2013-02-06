//
//  MIPositionConvert.h
//  MatchIt
//
//  Created by Bill on 13-2-2.
//
//

#import <UIKit/UIKit.h>

//用于描述路径方块的指向
typedef enum{
    MIDirectionNone,
    MIDirectionHorizontal,
    MIDirectionVertical,
    MIDirectionLeftTop,
    MIDirectionLeftBottom,
    MIDirectionRightTop,
    MIDirectionRightBottom
}MIDirection;

//基础坐标转换
typedef enum{
    MIFlipNone,
    MIFlipHorizontal,
    MIFlipVertical
}MIConversionFlip;

typedef enum{
    MISpinNone,
    MISpinPlus90Degrees,
    MISpinMinus90Degrees,
    MISpin180Degrees
}MIConversionSpin;

@interface MIConversion : NSObject{
    MIConversionFlip flip;
    MIConversionSpin spin;
}

@property(assign,nonatomic)MIConversionFlip flip;
@property(assign,nonatomic)MIConversionSpin spin;

-(id)init;
+(id)conversion;

-(id)initWithFlip:(MIConversionFlip)flip_ Spin:(MIConversionSpin)spin_;
+(id)conversionWithFlip:(MIConversionFlip)flip_ Spin:(MIConversionSpin)spin_;

@end

@interface MIPosition : NSObject{
    int x;
    int y;
    //只有用来描述路径的时候会被用到
    MIDirection direction;
}

@property(assign,nonatomic)int x;
@property(assign,nonatomic)int y;
@property(assign,nonatomic)MIDirection direction;

-(id)initWithX:(int)x_ Y:(int)y_;
+(id)positionWithX:(int)x_ Y:(int)y_;

@end

@interface MIPositionConvert : NSObject

+(int)positionToIndexWithX:(int)x y:(int)y;
+(MIPosition*)indexToPositonWithIndex:(int)index;


+(MIPosition*)screenToPositionWithX:(float)x Y:(float)y;

+(BOOL)blockISInAreaWithX:(int)x Y:(int)y;

//坐标转换,这里暂时不支持旋转和对称换算的叠加
+(MIPosition*)convertWithConversion:(MIConversion*)conversion Position:(MIPosition*)position inverse:(BOOL)inverse;
+(MIPosition*)convertWithConversion:(MIConversion*)conversion X:(int)x Y:(int)y inverse:(BOOL)inverse;

+(MIPosition*)horizontalFlipWithPosition:(MIPosition*)position;

@end
