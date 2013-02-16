//
//  MIMap.m
//  MatchIt
//
//  Created by Bill on 13-2-3.
//
//

#import "MIMap.h"
#import "MIPositionConvert.h"
#import "MIConfig.h"

@interface MIMap ()
-(NSMutableDictionary*)readPlistWithPlistName:(NSString*)plistName;
@end

@implementation MIMap

@synthesize map;
@synthesize blockInformation;

-(id)init{
    if(self=[super init]){
        [self loadMapWithTemplateIndex:12];
        
        NSMutableArray *infArray=[[self readPlistWithPlistName:@"BlockInformation"]objectForKey:@"BlockInformation"];
        self.blockInformation=[[NSMutableArray alloc]initWithArray:infArray];
    }
    return self;
}

-(void)dealloc{
    [map release];
    [blockInformation release];
    [super dealloc];
}

-(int)blockAtX:(int)x Y:(int)y{
    return [[[map objectAtIndex:y]objectAtIndex:x]intValue];
}

-(void)setBlockAtX:(int)x Y:(int)y block:(int)block{
    [[map objectAtIndex:y]setObject:[NSNumber numberWithInt:block] atIndex:x];
}

-(NSString*)imageNameWithImgId:(int)imgId{
    return [[blockInformation objectAtIndex:imgId]objectForKey:@"ImageName"];
}

-(NSString*)imageNameAtX:(int)x Y:(int)y{
    int imgId=[self blockAtX:x Y:y];
    return [self imageNameWithImgId:imgId];
}

-(NSMutableDictionary*)readPlistWithPlistName:(NSString*)plistName{
    NSString *error=nil;
    NSPropertyListFormat format;
    NSMutableDictionary *dict=nil;
    NSString *filePath=[[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSData *plistXML=[[NSFileManager defaultManager]contentsAtPath:filePath];
    dict=(NSMutableDictionary*)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&error];
    return dict;
}

-(void)loadMapWithTemplateIndex:(int)index{
    NSArray *mapTemplate=[[[self readPlistWithPlistName:@"MatchItMap"]objectForKey:@"MatchItMap"]objectAtIndex:index];
    
    if([mapTemplate count]<BLOCKS_YCOUNT){
        NSLog(@"地图太小");
        return;
    }
    
    NSMutableArray *templateBlocks=[NSMutableArray array];
    for(int i=0;i<BLOCKS_YCOUNT;i++){
        for(int j=0;j<BLOCKS_XCOUNT;j++){
            if([[mapTemplate objectAtIndex:i]count]<BLOCKS_XCOUNT){
                NSLog(@"地图太小");
                return;
            }
            if([[[mapTemplate objectAtIndex:i]objectAtIndex:j]intValue]==1){
                MIPosition *blockPosition=[MIPosition positionWithX:i Y:j];
                [templateBlocks addObject:blockPosition];
            }
        }
    }
    
    if([templateBlocks count]%2==1){
        NSLog(@"地图方块数为奇数");
        return;
    }
    
    int numbers[templateBlocks.count];
    BOOL ok=true;
    for(int i=0;i<templateBlocks.count;i++){
        ok=false;
        while (ok!=true) {
            ok=true;
            numbers[i]=arc4random()%templateBlocks.count; 
            for(int j=0;j<i;j++){
                if(numbers[j]==numbers[i]){
                    ok=false;
                }
            }
        }
    }
    
    NSMutableArray *templateBlocks_=[NSMutableArray array];
    for(int i=0;i<templateBlocks.count;i++){
        NSLog(@"%i",numbers[i]);
        [templateBlocks_ addObject:[templateBlocks objectAtIndex:numbers[i]]];
    }
    
    self.map=[[NSMutableArray alloc]initWithArray:mapTemplate];
    
    for(int i=0;i<templateBlocks_.count;i+=2){
        MIPosition *thisBlock=[templateBlocks_ objectAtIndex:i];
        MIPosition *nextBlock=[templateBlocks_ objectAtIndex:i+1];
        int blockInf=1+arc4random()%5;
        //0~(x-1)
        [[map objectAtIndex:thisBlock.x]setObject:[NSNumber numberWithInt:blockInf]atIndex:thisBlock.y];
        [[map objectAtIndex:nextBlock.x]setObject:[NSNumber numberWithInt:blockInf]atIndex:nextBlock.y];
    }
    
}

@end
