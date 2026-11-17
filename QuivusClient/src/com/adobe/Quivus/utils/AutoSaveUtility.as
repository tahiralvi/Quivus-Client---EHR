package com.adobe.Quivus.utils
{
	import com.adobe.Quivus.events.quickInput.DeleteTempQuickInputEvent;
	import com.adobe.Quivus.events.quickInput.LoadTempQuickInputByFileNameEvent;
	import com.adobe.Quivus.events.quickInput.SaveTempQuickInputEvent;
	import com.adobe.Quivus.events.quickInput.VerifyTempQuickInputEvent;
	import com.adobe.Quivus.model.AppModelLocator;
	import com.adobe.Quivus.vo.QuickInput.QuickInputVO;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import valueObjects.QuickInputDTO;

	public class AutoSaveUtility
	{
		private static var model: AppModelLocator = AppModelLocator.getInstance();
		
		 
		
		public function AutoSaveUtility()
		{
		}
		
		public static function isQuickInputExists(func:Function):Boolean
		{
			var flag:Boolean = false;
			var filePath: String = model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq + "_" + model.loggedInUserDTO.UserId + "_" + model.loadedPatientId + ".ri";
			
			try
			{
				var vtqiEvent : VerifyTempQuickInputEvent = new VerifyTempQuickInputEvent(filePath, func);
				CairngormEventDispatcher.getInstance().dispatchEvent( vtqiEvent );
				
				
				flag = model.tempQIExists;
			}
			catch(error:Error)
			{
				trace("AutoSaveUtility::saveQuickInput -- Error: "+ error.getStackTrace());
			}	
			
			return flag;
		}
		
		public static function saveQuickInput(obj:QuickInputDTO):void
		{
			var filePath: String = model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq + "_" + model.loggedInUserDTO.UserId + "_" + model.loadedPatientId;// + ".ri";//now .ri will be managed at back-end  
			
			try
			{	
				
				var stqiEvent : SaveTempQuickInputEvent = new SaveTempQuickInputEvent(filePath);
				CairngormEventDispatcher.getInstance().dispatchEvent( stqiEvent );
				
				
				/*obj.qi.Visit = model.visitDTO;				
				
				obj.s = "mansoor test";
				
				// First, generate your ByteArray from the VO.
				var byteArray : ByteArray = new ByteArray();
				
				byteArray.writeObject( obj );
				
				// Resolve your file location.
				var file : File = File.applicationStorageDirectory.resolvePath(filePath);
				var fileStream:FileStream = new FileStream();
				
				// Save the file to the given location.
				fileStream.open(file, FileMode.WRITE);
				fileStream.writeBytes( byteArray );
				fileStream.close();*/				
			}
			catch(error:Error)
			{
				trace("AutoSaveUtility::saveQuickInput -- Error: "+ error.getStackTrace());
			}
		}
			
		public static function loadQuickInput(func:Function):void
		{
			var filePath: String = model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq + "_" + model.loggedInUserDTO.UserId + "_" + model.loadedPatientId + ".ri";
			
			try
			{
				
				var ltqiEvent : LoadTempQuickInputByFileNameEvent = new LoadTempQuickInputByFileNameEvent(filePath,func);
				CairngormEventDispatcher.getInstance().dispatchEvent( ltqiEvent );
				
				
				/*var file : File = File.applicationStorageDirectory.resolvePath(filePath);
				var fileStream:FileStream = new FileStream();
				
				var data : ByteArray = new ByteArray();
				
				// Save the file to the given location.
				fileStream.open(file, FileMode.READ);
				
				//fileStream.readObject();
				
				fileStream.readBytes(data, 0, file.size);
				
				fileStream.close();				
				
				
				// Use the ByteArray.readObject method to reconstruct the object.
				var quickInput:QuickInputVO = data.readObject() as QuickInputVO ;*/
				
				//var quickInput:QuickInputVO;
				
				// Cast the object and assign it to our data container.
				//quickInput = obj as QuickInputVO;
				
				//return model.quickInputDTO;
			
				//if(qiToSave ==  null)
				// Alert.show("maa ke ankh!!");
			}
			catch(error:Error)
			{
				trace("AutoSaveUtility::loadQuickInput -- Error: ", error.getStackTrace());
			}
		}	
		
		public static function deleteQuickInput():void
		{
			try
			{
				var filePath: String = model.userSelectedClinicBranchDTO.ClinicBranch.ClinicBranchIdSeq + "_" + model.loggedInUserDTO.UserId + "_" + model.loadedPatientId + ".ri";
				
				var dtqiEvent : DeleteTempQuickInputEvent = new DeleteTempQuickInputEvent(filePath);
				CairngormEventDispatcher.getInstance().dispatchEvent( dtqiEvent );
				
				
				/*var file : File = File.applicationStorageDirectory.resolvePath(filePath);
				
				if(file.exists)
					file.deleteFile();*/
			}
			catch(error:Error)
			{
				trace("AutoSaveUtility::deleteQuickInput -- Error: \n", error.getStackTrace());
			}
		}
	
	}
}