//
//  MIMap.h
//  MatchIt
//
//  Created by Bill on 13-2-3.
//
//

#import <Foundation/Foundation.h>

//MIMap储存连连看游戏地图,并且提供一些基本的地图操作的方法
//地图中只储存方块的类型,不会储存方块对象
@interface MIMap : NSObject{
    NSMutableArray *map;
    NSMutableArray *blockInformation;
}

@property(retain,nonatomic)NSMutableArray *map;
@property(retain,nonatomic)NSMutableArray *blockInformation;

-(id)init;
-(int)blockAtX:(int)x Y:(int)y;
-(NSString*)imageNameWithImgId:(int)imgId;
-(NSString*)imageNameAtX:(int)x Y:(int)y;
-(void)loadMapWithTemplateIndex:(int)index;

@end
