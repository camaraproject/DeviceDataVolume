
@Device_Data_Volume
Feature: CAMARA Device Data Volume API - Operation getDeviceDataVolumeStatus

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specifies in device-data-volume.yaml

  Background: Common getDeviceDataVolumeStatus setup
    Given an environment at "apiRoot"
    And the resource "/device-data-volume/vwip/retrieve"                                                            
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is compliant with the schema RequestDeviceDataVolume at "/components/schemas/RequestDeviceDataVolume"
	
#############Happy Path Scenarios##################	

  @device_data_volume_getDeviceDataVolumeStatus_200.01_retrieve_success_scenario
  Scenario: Retrieve the estimated remaining data volume for a device
    Given the request body property "$.device" is set to identify a valid testing device supported by the service
    When the HTTPS "POST" request getDeviceDataVolumeStatus is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body property "$.dataVolumeCategory" is present and has value "<200MiB", "<1GiB",  "<5GiB", or ">=5GiB"
 

  @device_data_volume_02_check_status_success
  Scenario: Check if the remaining data volume for a device is above a given threshold
    Given a valid devicestatus request body 
    And the request body property "$.device" is set to a valid testing device and supported by the service
     When  the HTTPS "POST" request is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with Boolean value 
    And the response property "$.status" is 200
    And the response property "$.code" is "OK"
    And the response property "$.message" contains a user friendly text
     

#############Error Response Scenarios##################
	
  @device_data_volume_03_retrieve_status_with_invalid_parameter
  Scenario: retrieve status request with invalid parameter 
    Given the request body is not compliant with the schema "/components/schemas/CheckRequest"
    When the request "retrieve" is sent
    Then Response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @device_data_volume_04_expired_access_token
   Scenario: Expired access token
    Given a valid CheckRequest request body 
    And header "Authorization" is set to expired token
    When the  request "retrieve" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_data_volume_05_no_authorization_header
   Scenario: No Authorization header
    Given a valid CheckRequest request body 
    And header "Authorization" is not available
    When the  request "CheckRequest " is sent 
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_data_volume_06_invalid_access_token
   Scenario: Invalid access token
    Given a valid CheckRequest request body 
    And header "Authorization" set to an invalid access token
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text
	
  @device_data_volume_07_retrieve_status_inconsistent_access_token
   Scenario: Inconsistent access token context for the device
    # To test this, a token has to be obtained for a different device
    Given a valid CheckRequest request body
    And the request body property "$.device" is set to a valid testing device supported by the service
    And header "Authorization" set to access token referring different device
    When the request "retrieve" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"
    And the response property "$.message" contains a user friendly text
	
  
 # Generic 400 errors

  @device_data_volume_08_retrieve_status_no_request_body
  Scenario: Missing request body
    Given the request body is not included
    When the HTTP "POST" request is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @device_data_volume_09_retrieve_status_400_empty_request_body
  Scenario: Empty object as request body
    Given the request body is set to "{}"
    When the HTTP "POST" request is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text


 @device_data_volume_10_retrieve_status_required_device_identifier_missing
  Scenario: Required device identifier is  missing
    Given the request body property "$.device" is not included
    When the HTTP "POST" request is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text


