class ApiController < ApplicationController
	require "rest-client"
	require "json"


	def self.send_itxt_request(senderid, contact, message)

		base_url 	  = "http://itxt.ikernelnetworks.com/api/v1/sendsms?"
		key		 	  = "6A43KdlCrEyObnjeJYMVvi2ZqgG0PDkc"
		senderid 	  = senderid
		contact  	  = contact
		message  	  = message    #"Sending SMS Via iTxt API with ruby on rails"
		schedule_date = "now" 
		#schedule_time = ""

		signed_url = URI.encode(
					 base_url							+
					 "key=#{key}"						+
					 "&contact=#{contact}"				+
					 "&senderid=#{senderid}"			+
					 "&message=#{message}"				+
					 "&schedule_date=#{schedule_date}"	
					 )		



		response = RestClient.get(
			signed_url, {:accept => :json}
			)

		response.code
	end
		
end
