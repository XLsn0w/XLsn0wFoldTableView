/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *	 \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *	  \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/

#import <UIKit/UIKit.h>

@class  XLsn0wCollectionViewFlowLayout;

@protocol XLsn0wCollectionViewFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@required
/**
 *  number of column in section protocol delegate methods
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView
                     layout:(XLsn0wCollectionViewFlowLayout *)layout
   numberOfColumnsInSection:(NSInteger)section;

@end

@interface XLsn0wCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<XLsn0wCollectionViewFlowLayoutDelegate> xlDelegate;

@property (nonatomic) BOOL enableStickyHeaders; //Defalut is NO, set it's YES will sticky the section header.

@end
