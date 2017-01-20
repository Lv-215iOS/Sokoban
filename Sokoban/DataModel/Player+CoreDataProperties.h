//
//  Player+CoreDataProperties.h
//  Sokoban
//
//  Created by pasik_01 on 20.01.17.
//
//

#import "Player+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@class Level;

@interface Player (CoreDataProperties)

+ (NSFetchRequest<Player *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *score;
@property (nullable, nonatomic, retain) NSSet<Level *> *levels;

@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addLevelsObject:(Level *)value;
- (void)removeLevelsObject:(Level *)value;
- (void)addLevels:(NSSet<Level *> *)values;
- (void)removeLevels:(NSSet<Level *> *)values;

@end

NS_ASSUME_NONNULL_END
