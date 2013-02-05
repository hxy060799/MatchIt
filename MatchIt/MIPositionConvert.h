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
    MIConversionNone,
    MIConversionHorizontalFlip,
    MIConversionVerticalFlip,
    MIConversionPlus90Degrees,
    MIConversionMinus90Degrees,
    MIConversionPlus180Degrees
}MIConversion;

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
+(MIPosition*)ConvertPositionWithConversion:(MIConversion)conversion Position:(MIPosition*)position inverse:(BOOL)inverse;
//使用给定的转换方式的逆运算进行转换
+(MIPosition*)inverseConvertWithConversion:(MIConversion)conversion Position:(MIPosition*)position;

+(MIPosition*)horizontalFlipWithPosition:(MIPosition*)position;

@end
