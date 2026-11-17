package  com.adobe.Quivus.vo.patientProfileCustomization {
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class MainCategoryVO {

		public var label 					: String;
		public var mainCategoryId 			: int;
		public var mainCategoryName 		: String;

		public var children:ArrayCollection	= new ArrayCollection();
		
		public function MainCategoryVO(label: String, mainCategoryId:int, mainCategoryName: String) 		
		{
			this.label				= label;
			this.mainCategoryId		= mainCategoryId;
			this.mainCategoryName	= mainCategoryName;	
		}
	}
}