public class TH_ColorsCollectionsList {
	List<TH_Color> colorList = new List<TH_Color>{TH_Color.RED, TH_Color.GREEN, TH_Color.BLUE};
	TH_Color[] colorArray = new List<TH_Color>();
	List<TH_Color> moreColorList = new List<TH_Color>();

	public TH_ColorsCollectionsList() { 
		moreColorList.add(TH_Color.ORANGE);
		moreColorList.add(TH_Color.PURPLE);
	}
	
	public TH_Color getMoreColorByGetMethod(Integer index) {
		return this.moreColorList.get(index);
	}

	public TH_Color getMoreColorByIndex(Integer index) {
		return this.moreColorList[index];
	}
	
	public void iterateOverColorLists(TH_ColorConsumerStrategyInterface colorConsumer) {
		for (TH_Color color : colorList) {
			colorConsumer.execute(color); 
		}
	}
}