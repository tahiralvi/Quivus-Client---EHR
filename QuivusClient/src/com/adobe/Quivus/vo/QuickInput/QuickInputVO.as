
package com.adobe.Quivus.vo.QuickInput
{
	import valueObjects.QuickInputDTO;
	
	[RemoteClass(alias="com.comtaste.model.Persona")]
	
	public class QuickInputVO
	{
		public var qi:QuickInputDTO = new QuickInputDTO();
		
		public function QuickInputVO()
		{
			//this.qi = qi;
		}
	}
}