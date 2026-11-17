package com.gazuntite.common.command
{
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.gazuntite.common.delegate.LoadPatientMedDelegate;
	import com.gazuntite.common.event.LoadPatientMedEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	public class LoadPatientMedCommand  implements Command 
	{
		private var responder:Responder;
		private var delegate:LoadPatientMedDelegate;
		private var LE:LoadPatientMedEvent;
		
		private var callBack			: Function;
		
		public function execute( cgEvent:CairngormEvent ) : void {
			
			responder = new Responder(result, fault);				
			delegate  = new LoadPatientMedDelegate( responder );			
			
			var LE:LoadPatientMedEvent = cgEvent as LoadPatientMedEvent;
			
			callBack = LE.resultHandlerFunction;
			
			delegate.GetPatientPrescription(LE.data, LE.encounterId, LE.gaxenPatientId);
		}
		
		public function result( rpcEvent : ResultEvent ) : void 
		{	
			 var patientMedAC:ArrayCollection 		= new ArrayCollection();
			 var patientChronicMedAC:ArrayCollection = new ArrayCollection();
			
			 var patientMedAC_inactive:ArrayCollection 		= new ArrayCollection();
			 var patientChronicMedAC_inactive:ArrayCollection = new ArrayCollection();
			
			var response:XML = XML(rpcEvent.message.body.toString());
			response = removeDefaultNamespaceFromXML(response);
			
			for(var i:int = 0; i < response.PMedication.Messages.length(); i++)
			{
				var drugName:String = response.PMedication.Messages[i].@DrugName.toString();
				var dose:String = response.PMedication.Messages[i].@Dose.toString();
				var quantity:String = response.PMedication.Messages[i].@Quantity.toString(); 
				var ndc:String = response.PMedication.Messages[i].@NDCCODE.toString(); 
				var Refill:String = response.PMedication.Messages[i].@Refill.toString();
				var isPRN:String = response.PMedication.Messages[i].@isPRN.toString();
				var sig:String = response.PMedication.Messages[i].@SIG.toString();
				var prescriber = response.PMedication.Messages[i].@FirstName.toString() + " " + response.PMedication.Messages[i].@LastName.toString();
				
				var Obj:Object = new Object();
				
				Obj.VisitDate 	= response.PMedication.Messages[i].@VisitDate.toString();
				Obj.Type	 	= response.PMedication.Messages[i].@Type.toString();
				Obj.drugName 	= drugName;
				Obj.Sig 		= sig;
				Obj.Dose 		= dose;
				Obj.Quantity 	= quantity+", "+response.PMedication.Messages[i].@QuantityForm.toString();
				//Obj.NDCCODE 	= ndc;
				Obj.Refill 		= Refill;
				Obj.isPRN 		= isPRN;
				
				Obj.frequency 	= response.PMedication.Messages[i].@frequency.toString();					
				Obj.Route 		= response.PMedication.Messages[i].@Route.toString();
				Obj.Prescriber  = prescriber;
				
				if(response.PMedication.Messages[i].@isActive.toString() == "false")
				{
					patientMedAC_inactive.addItem(Obj);
				}
				else
				{
					patientMedAC.addItem(Obj);	
				}
			}
			
			for(var j:int=0; j<response.PChronicMedication.Messages.length(); j++)
			{
				var drugName1:String 	= response.PChronicMedication.Messages[j].@DrugName.toString();
				var dose1:String 		= response.PChronicMedication.Messages[j].@Dose.toString();
				var quantity1:String 	= response.PChronicMedication.Messages[j].@Quantity.toString(); 
				var ndc1:String 			= response.PChronicMedication.Messages[j].@NDCCODE.toString(); 
				var isPRN1:String 		= response.PChronicMedication.Messages[j].@isPRN.toString();
				var Refill1:String 		= response.PChronicMedication.Messages[j].@Refill.toString();
				
				var Obj1:Object = new Object();
				
				Obj1.Type 		= response.PChronicMedication.Messages[j].@Type.toString();
				Obj1.VisitDate	= response.PChronicMedication.Messages[j].@VisitDate.toString();
				Obj1.drugName 	= drugName1;
				
				Obj1.SIG			= response.PChronicMedication.Messages[j].@SIG.toString();										
				Obj1.Dose 		= dose1;
				Obj1.Quantity 	= quantity1 + ", "+response.PChronicMedication.Messages[j].@QuantityForm.toString();;
				
				Obj1.Status	 	= response.PChronicMedication.Messages[j].@MessageStatus.toString();
				Obj1.NDCCODE 	= ndc1;
				Obj1.Refill 		= Refill1;
				Obj1.isPRN 		= isPRN1;
				
				if(response.PChronicMedication.Messages[j].@isActive.toString() == "false")
				{
					patientChronicMedAC_inactive.addItem(Obj1);
				}
				else
				{
					patientChronicMedAC.addItem(Obj1);
				}
			}
			
			if( null != callBack )
			{
				callBack(patientMedAC, patientChronicMedAC, patientMedAC_inactive, patientChronicMedAC_inactive);
				//callBack(new XML(rpcEvent.message.body.toString()));
			}
		}
		
		private function removeDefaultNamespaceFromXML(xml:XML):XML
		{
			var rawXMLString:String = xml.toXMLString();
			
			/* Define the regex pattern to remove the default namespace from the 
			String representation of the XML result. */
			var xmlnsPattern:RegExp = 
				new RegExp("xmlns=[^\"]*\"[^\"]*\"", "gi");
			
			/* Replace the default namespace from the String representation of the 
			result XML with an empty string. */
			var cleanXMLString:String = rawXMLString.replace(xmlnsPattern, "");
			
			// Create a new XML Object from the String just created
			return new XML(cleanXMLString);
		}
		public function fault( rpcEvent : Object ) : void 
		{
			Alert.show("Fault occured in LoadPatientPrescriptionCommand.\n"+rpcEvent.toString());
		}
	}
}