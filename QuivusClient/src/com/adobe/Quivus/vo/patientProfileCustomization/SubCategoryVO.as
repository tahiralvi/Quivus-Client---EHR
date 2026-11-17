package  com.adobe.Quivus.vo.patientProfileCustomization {
	
	[Bindable]
	public class SubCategoryVO {

		public var label 					: String;
		public var subCategoryId 			: int;
		public var subCategoryName 			: String;

		public function SubCategoryVO(label: String, subCategoryId:int, subCategoryName: String) 		
		{
			this.label=label;
			this.subCategoryId=subCategoryId;
			this.subCategoryName=subCategoryName;			
		}
	}
}