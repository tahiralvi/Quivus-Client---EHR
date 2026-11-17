package com.gazuntite.provider.live.services.administration.dto
{
	import com.gazuntite.common.util.xml.XmlConstants;
	import com.gazuntite.common.util.xml.XmlUtils;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class RoleRightDTO
	{
		public function RoleRightDTO()
		{
		}
		
		private var m_sTagName:String;
		
		private var m_sName:String;
		
		private var m_sParentName:String;
		
		private var m_bIsViewAllowed:String;
		
		private var m_bIsEditAllowed:String;
		
		private var m_bIsSignAllowed:String;//in case of encounter list only
		
		private var m_bIsImportAllowed:String;//in case of QI-diagnosis only
		
		private var m_sm_iId:int;
		private var m_sIsDirty:String;
		
		private var m_acChildren:ArrayCollection;
		
		public function get TagName():String
		{
			return m_sTagName;
		}

		public function set TagName(value:String):void
		{
			m_sTagName = value;
		}

		public function get children():ArrayCollection
		{
			return m_acChildren;
		}
		
		public function set children(value:ArrayCollection):void
		{
			m_acChildren = value;
		}
		
		public function get IsEditAllowed():String
		{
			return m_bIsEditAllowed;
		}
		
		public function set IsEditAllowed(value:String):void
		{
			m_bIsEditAllowed = value;
		}
		
		public function get IsViewAllowed():String
		{
			return m_bIsViewAllowed;
		}
		
		public function set IsViewAllowed(value:String):void
		{
			m_bIsViewAllowed = value;
		}
		
		public function get IsSignAllowed():String
		{
			return m_bIsSignAllowed;
		}
		
		public function set IsSignAllowed(value:String):void
		{
			m_bIsSignAllowed = value;
		}
		
		public function get IsImportAllowed():String
		{
			return m_bIsImportAllowed;
		}
		
		public function set IsImportAllowed(value:String):void
		{
			m_bIsImportAllowed = value;
		}
		public function get IsDirty():String
		{
			return m_sIsDirty;
		}
		
		public function set IsDirty(value:String):void
		{
			m_sIsDirty = value;
		}
		
		public function get ParentName():String
		{
			return m_sParentName;
		}
		
		public function set ParentName(value:String):void
		{
			m_sParentName = value;
		}
		
		public function get Name():String
		{
			return m_sName;
		}
		
		public function set Name(value:String):void
		{
			m_sName = value;
		}
		//for explicity show the label of each item in tree
		public function get label():String
		{
			return m_sName;
		}

		
		public function get Id():int
		{
			return m_sm_iId;
		}
		
		public function set Id(value:int):void
		{
			m_sm_iId = value;
		}

		
		public function FromXML(x:XML):void
		{
			TagName							= x.localName();
			
			Name							= x.@[XmlConstants.NAME];
			ParentName 						= x.@[XmlConstants.PARENT_NAME];
			IsViewAllowed 					= x.@[XmlConstants.IS_VIEW_ALLOWED];
			IsEditAllowed 					= x.@[XmlConstants.IS_EDIT_ALLOWED];
			Id 								= x.@[XmlConstants.ID] ;		
			IsDirty							= x.@[XmlConstants.IS_DIRTY] ;		
			
			if(TagName == 'Encounterlist')
				IsSignAllowed 					= x.@[XmlConstants.IS_SIGN_ALLOWED];	
			if(TagName == 'Diagnosis' && ParentName == 'Assessment')
				IsImportAllowed 				= x.@[XmlConstants.IS_IMPORT_ALLOWED];
			
			
			for(var i:int=0;i<x.children().length();i++)
			{
				var xChild:XML = x.children()[i];
				
				var c:RoleRightDTO = new RoleRightDTO();
				c.FromXML(xChild);
				
				if(!children)
					children = new ArrayCollection();
				
				children.addItem(c);
			}
		}
		
		public function ToXML():XML
		{
			var xml:XML = XmlUtils.getNodeByTagName( TagName );
			
			xml.@[XmlConstants.NAME]					= Name;
			xml.@[XmlConstants.PARENT_NAME]				= ParentName;
			xml.@[XmlConstants.IS_VIEW_ALLOWED]			= IsViewAllowed;
			xml.@[XmlConstants.IS_EDIT_ALLOWED]			= IsEditAllowed;
			xml.@[XmlConstants.ID] 						= Id;
			xml.@[XmlConstants.IS_DIRTY] 				= IsDirty;
			
			if(TagName == 'Encounterlist')
				xml.@[XmlConstants.IS_SIGN_ALLOWED]		= IsSignAllowed;
			if(TagName == 'Diagnosis' && xml.@[XmlConstants.PARENT_NAME] == 'Assessment')
				xml.@[XmlConstants.IS_IMPORT_ALLOWED]	= IsImportAllowed;
			
			if(children)
			{
				var i:int
				for(i=0;i<children.length;i++)
				{
					var c:RoleRightDTO =children.getItemAt(i) as RoleRightDTO;
					xml.appendChild(c.ToXML());
				}
			}
			return xml;
		}



	}
}