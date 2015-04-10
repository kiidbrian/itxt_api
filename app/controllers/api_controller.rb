class ApiController < ApplicationController
	require "rest-client"
	require "json"


	def self.send_itxt_request(senderid, contact, message, schedule_time, schedule_date)

		base_url 	  = "http://itxt.ikernelnetworks.com/api/v1/sendsms?"
		key		 	  = "6A43KdICrEyObnjeJYMVvi2ZqgG0PDkc"
		senderid 	  = senderid
		contact  	  = contact
		message  	  = message    #"Sending SMS Via iTxt API with ruby on rails"
		schedule_date = schedule_date 
		schedule_time = schedule_time

		# condition should come here
		# if schedule_time is specified then
		# 
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

		res = JSON.parse(response.body)
		#response.code
		#response.headers
		message  = get_status_message(res['status'])

		{ message: message, status_code: res['status'] }
	end

	

	# use this method for a scheduled message
	# method called if schedule_time is specified
	def self.schedule_message
		
	end

	# Convert iTxt BULK SMS response code to meaningful message
	# for customer
	def self.get_status_message(status)
		case status
		when '1000'
			'Successful'
		when '1002'
			'SMS sending failed'
		when '1004'
			'Message is scheduled'
		when '1005'
			'Message could not be scheduled'
		when '1001'
			'No API key supplied'
		when '1003'
			'No message content supplied'
		when '1006'
			'No contact supplied'
		when '1007'
			'No senderid supplied'
		when '1010'
			'Scheduled date not supplied (eg. 2014-10-05)'
		when '1011'
			'Invalid contact length'
		when '1012'
			'Insufficient credits'
		when '1013'
			'No account registered against that APIKEY'
		else
			"An error occured. Please try again"\
			"in a few minutes. Thank you. --#{status}--"
		end
	end
		
end
