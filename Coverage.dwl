%dw 2.0
import * from dw::core::Strings
output application/json
---
/* vars.outputResponse default [] ++ [vars.inputPayload -- "resource" ++ {
	resource: vars.inputPayload.resource ++ {
	contained: [
		payload
	]}
}] */
// vars.outputResponse default [] ++ payload.payload
{
	"resourceType": vars.patientMedsPayload.resourceType,
    "type": vars.patientMedsPayload."type",
    "total": vars.patientMedsPayload.total,
    "link": vars.patientMedsPayload.link,
    "entry": vars.patientMedsPayload.entry map (entry,index) ->
    	entry - "resource" ++ ({
    		resource: entry.resource ++ {
    			contained: payload.payload filter $["id"] == substringAfterLast(entry.resource.informationSource.reference,"/")
    		}
    	})
    
} 
