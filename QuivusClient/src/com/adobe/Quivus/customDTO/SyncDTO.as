package com.adobe.Quivus.customDTO
{
	[Bindable]
	public class SyncDTO
	{
		
		private var _status:String					= "";
		private var _message:String					= "";
		private var _showProgress:Boolean			= true;
		private var _ProgressValue:int				= 0;
		private var _ProgressTotal:int				= 1;

		public function get status():String
		{
			return _status;
		}

		public function set status(value:String):void
		{
			_status = value;
		}


		public function get message():String
		{
			return _message;
		}

		public function set message(value:String):void
		{
			_message = value;
		}


		public function get showProgress():Boolean
		{
			return _showProgress;
		}

		public function set showProgress(value:Boolean):void
		{
			_showProgress = value;
		}


		public function get ProgressValue():int
		{
			return _ProgressValue;
		}

		public function set ProgressValue(value:int):void
		{
			_ProgressValue = value;
		}

		public function get ProgressTotal():int
		{
			return _ProgressTotal;
		}

		public function set ProgressTotal(value:int):void
		{
			_ProgressTotal = value;
		}

		
		public function SyncDTO()
		{
		}
	}
}