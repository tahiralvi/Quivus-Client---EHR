package com.adobe.Quivus.utils.slideout
{
	import com.adobe.Quivus.view.controls.custom.SlideOutPanel;
	import com.gazuntite.common.view.events.QSViewStateEvent;

	public class SlideoutUtils
	{
		private var m_oRegisterPanel:SlideOutPanel;
		private var m_oCurrentExpandedPanel:SlideOutPanel ;
		private var currentSlideOutPanel:SlideOutPanel ;
		
		
		public function QSAutoSlideChangeHandler(event:QSViewStateEvent):void
		{
			if( currentSlideOutPanel && currentSlideOutPanel != event.currentTarget && 
				event.viewState == QSViewStateEvent.VIEW_SLIDE_OUT && currentSlideOutPanel.isSlideOut )
			{
				//currentSlideOutPanel.ToggleSlideOut();
				//currentSlideOutPanel["IsNotesPanelVisible"] = false;
			}
			
			currentSlideOutPanel = event.currentTarget as SlideOutPanel;
			if( event.viewState == QSViewStateEvent.VIEW_SLIDE_IN )
				currentSlideOutPanel.ExpandedView = true;
		}
		
		public function QSAutoCollapseHandler(event:QSViewStateEvent):void
		{
			if( currentExpandedPanel && currentExpandedPanel != event.currentTarget && 
				event.viewState == QSViewStateEvent.EXPANDED_VIEW &&
				!currentExpandedPanel.isSlideOut && !event.currentTarget.isSlideOut )
				currentExpandedPanel.ExpandedView = false;
			
			//ignore state change if panel is in SlideOut state
			if( currentExpandedPanel != event.currentTarget && !event.currentTarget.isSlideOut )
			{
				currentExpandedPanel = event.currentTarget as SlideOutPanel;
			}
			
		}

		public function get currentExpandedPanel():SlideOutPanel
		{
			return m_oCurrentExpandedPanel;
		}

		public function set currentExpandedPanel(value:SlideOutPanel):void
		{
			m_oCurrentExpandedPanel = value;
		}

	}
}