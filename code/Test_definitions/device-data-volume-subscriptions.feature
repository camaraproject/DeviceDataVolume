 
@DeviceDataVolumeSubscription
Feature: Device Data Volume Subscriptions API, vwip - Operation createDeviceDataVolumeSubscription

# Input to be provided by the implementation to the tests
# References to OAS spec schemas refer to schemas specified in device-data-volume-subscriptions.yaml, version vwip

  Background: Common Device Data Volume setup
    Given the resource "{apiroot}/device-data-volume-subscriptions/vwip" as base-url                                                           
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value

######### Happy Path Scenarios #################################

@device_data_volume_subscriptions_01_create_subscription_synchronously
  Scenario:  Create device data volume subscription synchronously
    Given that subscriptions are created synchronously
    And a valid subscription request body 
    When the  request "createDeviceDataVolumeSubscription" is sent 
    Then the response code is 201
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Subscription"

@device_data_volume_subscriptions_02_create_subscription_asynchronously
  Scenario:  Create device data volume subscription asynchronously
    Given that subscriptions are created asynchronously
    And a valid subscription request body 
    When the  request "createDeviceDataVolumeSubscription" is sent 
    Then the response code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/SubscriptionAsync"
	
@device_data_volume_subscriptions_03_Operation_to_retrieve_list_of_subscriptions_when_no_records
  Scenario: Get a list of subscriptions when no subscriptions 
    Given a client without subscriptions created
    When the request "retrieveSubscriptionList" is sent 
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an empty array

@device_data_volume_subscriptions_04_Operation_to_retrieve_list_of_subscriptions
  Scenario: Get a list of subscriptions.
    Given a client with subscriptions created
    When the request "retrieveSubscriptionList" is sent 
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body has an array of items and each item complies with the OAS schema at "/components/schemas/Subscription"

 @device_data_volume_subscriptions_05_Operation_to_retrieve_subscription_based_on_an_existing_subscription-id
  Scenario: Get a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the request "retrieveSubscription" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/Subscription"

 @device_data_volume_subscriptions_06_Operation_to_delete_subscription_based_on_an_existing_subscription-id
  Scenario: Delete a subscription based on existing subscription-id.
    Given the path parameter "subscriptionId" is set to the identifier of an existing subscription
    When the request "deleteSubscription" is sent
    Then the response code is 202 or 204
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And if the response property $.status is 204 then response body is not available
    And if the response property $.status is 202 then response body complies with the OAS schema at "/components/schemas/SubscriptionAsync"

@device_data_volume_subscriptions_07_Receive_notification_when_device_data_volume_changed_to_50_percent
  Scenario: Receive notification for data-50-percent event
    Given that subscriptions are created synchronously
    And a valid subscription request body 
    And the request body property "$.type" is " data-50-percent"	
    When the request "createDeviceDataVolumeSubscription" is sent
    Then the response code is 201
    And if the device data volume reach to 50 percent
    Then event notification "data-50-percent" is received on callback-url
    And sink credentials are received as expected
    And notification body complies with the OAS schema at "##/components/schemas/EventDataUsage50Percent"
    And type="org.camaraproject.device-data-volume-subscriptions.v0.data-50-percen"


@device_data_volume_subscriptions_08_subscription_expiry
  Scenario: Receive notification for subscription-ends event on expiry  
    Given that subscriptions are created synchronously
    And a valid subscription request body
    And the request body property "$.subscriptionExpireTime" is set to a value in the near future
    When the request "createDeviceDataVolumeSubscription" is sent
    Then the response code is 201 
    And the subscription is expired
    And event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-data-volume-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_EXPIRED"

@device_data_volume_status_subscriptions_09_subscription_ends_when_max_events_reached
   Scenario: Receive notification for subscription-ends event on max events reached 
    Given that subscriptions are created synchronously
    And a valid subscription request body  
    And the request body property "$.type" is "data_50_percent"
    And the request body property "$.subscriptionMaxEvents" is set to 1 
    When the request "createDeviceDataVolumeSubscription" is sent
    Then the response code is 201 
    Then event notification "data_50_percent" is received on callback-url
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-data-volume-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "MAX_EVENTS_REACHED"

  @device_data_volume_subscriptions_10_subscription_delete_event_validation
   Scenario: Receive notification for subscription-ends event on deletion 
    Given that subscriptions are created synchronously
    And a valid subscription request body  
    When the request "createDeviceDataVolumeSubscription" is sent
    Then the response code is 201 
    When the request "deleteSubscription" is sent
    Then the response code is 202 or 204	
    Then event notification "subscription-ends" is received on callback-url
    And notification body complies with the OAS schema at "##/components/schemas/EventSubscriptionEnds"
    And type="org.camaraproject.device-data-volume-subscriptions.v0.subscription-ends"
    And the response property "$.terminationReason" is "SUBSCRIPTION_DELETED"


############### Error response scenarios ###########################

  @device_data_volume_subscriptions_11_Create_device_data_volume_subscription_with_invalid_parameter
  Scenario:  Create subscription with invalid parameter
    Given the request body is not compliant with the schema "/components/schemas/SubscriptionRequest"
    When the  request "createDeviceDataVolumeSubscription" is sent 
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

@device_data_volume_subscriptions_12_creation_of_subscription_with_expiry_time_in_past
  Scenario: Expiry time in past
    Given a valid subscription request body
    And request body property "$.subscriptionExpireTime" in past
    When the  request "createDeviceDataVolumeSubscription" is sent 
    Then the response code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

 @device_data_volume_subscription_13_invalid_protocol
   Scenario: subscription creation with invalid protocol
    Given a valid subscription request body 
    And the request property "$.protocol" is not "HTTP"
    When the request "createDeviceDataVolumeSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_PROTOCOL"
    And the response property "$.message" contains a user friendly text

@device_data_volume_subscription_14_invalid_credential_type
   Scenario: subscription creation with invalid credential type
    Given a valid subscription request body 
    And the request property "$.credentialType" is not "ACCESSTOKEN"
    When the request "createDeviceDataVolumeSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text
	
@device_data_volume_subscription_15_invalid_access_token_type
   Scenario: subscription creation with invalid access token type 
    Given a valid subscription request body 
    And the request property "$.accessTokenType" is not "bearer"
    When the request "createDeviceDataVolumeSubscription" is sent
    Then the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN" or "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

@device_data_volume_subscription_16_invalid_credentials
   Scenario: subscription creation with invalid credentials
    Given a valid subscription request body 
    And header "Authorization" token is set to invalid credentials
    When the request "createDeviceDataVolumeSubscription" is sent
    Then the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

@device_data_volume_subscription_17_invalid_inconsistent_access_token
   Scenario: subscription creation with inconsistent access token for requested events subscription
  # To test this, a token have to be obtained for a different device
    Given a valid subscription request body 
    And the request body property "$.device" is set to a valid testing device supported by the service
    And header "Authorization" set to access token referring different device
    When the request "createDeviceDataVolumeSubscription" is sent
    Then the response property "$.status" is 403
    And the response property "$.code" is "SUBSCRIPTION_MISMATCH"
    And the response property "$.message" contains a user friendly text

@device_data_volume_subscription_18_unknown_subscription_id
   Scenario: Get subscription when subscription-id is unknown to the system 
    Given the path parameter property "$.subscriptionId" is unknown to the system
    When the request "retrieveSubscription" is sent
    Then the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text
