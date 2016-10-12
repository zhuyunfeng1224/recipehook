/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.
*/

@interface XCFDishModel : NSObject

- (BOOL)diggedByCurrentUser;
- (id)shareObjectIdentifier;

@end

@interface XCFEventInfoModel : NSObject

@property(retain, nonatomic) NSMutableArray *dishes;

@end

@interface XcfEventViewController: UIViewController
@property(retain, nonatomic) XCFEventInfoModel *eventInfo;
@property(retain, nonatomic) NSMutableArray *dishes;
@end

@interface XcfNewDishGridView: UICollectionViewCell

@property(retain, nonatomic) XCFDishModel *dish;
- (void)diggDish;

@end


%hook XcfEventViewController

- (void)viewDidLoad {
    %orig;
    NSLog(@"xiachufang hook=======!");
}

- (id)collectionView:(id)arg1 cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XcfNewDishGridView *cell = %orig;
    if (self.eventInfo && self.dishes && indexPath.row < self.dishes.count) {
        XCFDishModel *dish = self.dishes[indexPath.row];
        if (![dish diggedByCurrentUser] && [[dish shareObjectIdentifier] intValue] > 0) {
            [cell diggDish];
        }
    }
    return cell;
}

%end
