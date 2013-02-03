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
    MIDirectionRightBottom,
}MIDirection;

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

+(MIPosition*)horizontalFlipWithPosition:(MIPosition*)position;

@end
