package se.pixelshift.common.net.rpc.json
{
    import se.pixelshift.common.net.rpc.BaseRPCResponse;
    import se.pixelshift.common.net.rpc.BaseRPCService;
    import se.pixelshift.common.net.rpc.IRPCRequest;
    import se.pixelshift.common.net.rpc.IRPCResponse;
    import se.pixelshift.common.net.rpc.IRPCService;

    /*********************************************************
	 * JSON-RPC implementation of service.
	 * 
	 * @author tomas.augustinovic
	 *********************************************************/
	public class JsonRPCService extends BaseRPCService implements IRPCService
	{
		public function JsonRPCService(url:String)
		{
			super(url);
		}
		
		override protected function createResponse(initializer:Object):IRPCResponse
		{
			return new BaseRPCResponse(initializer);
		}
		
		override protected function createRequest(id:String, method:String, params:Array = null):IRPCRequest
		{
			return new JsonRPCRequest(id, method, params);
		}
		
		override protected function getRequestContentType():String
		{
			return "application/json";
		}
		
		override protected function encodeRequests(reqs:Array):String
		{
			var enc:Object;
			
			if (reqs.length == 1)
			{
				enc = reqs[0];
			}
			else
			{
				enc = [ ];
				for each (var req:Object in reqs)
				{
					(enc as Array).push(req);
				}
			}
			
			return JSON.stringify(enc);
		}
		
		override protected function parseResponse(resp:String):void
		{
			var data:Object = JSON.parse(resp);
			
			if (data is Array)
			{
				for each (var obj:Object in data)
				{
					_responses.push(createResponse(obj));
				}
			}
			else
			{
				_responses.push(createResponse(data));
			}
		}
	}
}
