# device-data-volume-subscriptions-retrieveDeviceDataVolumeSubscription
Feature: Device Data Volume Subscriptions API, vwip - Operation retrieveDeviceDataVolumeSubscription

  # Input to be provided by the implementation to the tester
  #
  # If the subscription leverages the 'device' object the following indication must be present:
  #    Implementation indications:
  #      * List of device identifier types which are not supported, such as: phoneNumber, networkAccessIdentifier, ipv4Address, ipv6Address
  #
  # Testing assets:
  #       A sink-url identified as "callbackUrl", which receives notifications
  #       A device object which device data volume is known by the network when connected.
  #       The known device data volume status of the testing device
  #
  # References to OAS spec schemas refer to schemas specified in device-data-volume-subscriptions.yaml

  Background: Common Device Data Volume Subscription setup
    Given an environment at "apiRoot"
    And the resource "/device-data-volume-subscriptions/vwip/subscriptions"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"

##########################
# Happy path scenarios
##########################

  @device_data_volume_subscriptions_03.1_retrieve_by_id_2legs
  Scenario: Check existing subscription is retrieved by id with a 2-legged access token
    Given a subscription exists and has a subscriptionId equal to "id"
    And the header "Authorization" is set to a valid access token which does not identify any device
    When the request "retrieveDeviceDataVolumeSubscription" is sent
    And the path parameter "subscriptionId" is set to "id"
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And the response property "$.id" is equal to "id"
    And the response property "$.config.subscriptionDetail.device" is present

  @device_data_volume_subscriptions_03.2_retrieve_by_id_3legs
  Scenario: Check existing subscription is retrieved by id with a 3-legged access token
    Given a subscription exists and has a subscriptionId equal to "id"
    And the header "Authorization" is set to a valid access token which identifies the device associated with the subscription
    When the request "retrieveDeviceDataVolumeSubscription" is sent
    And the path parameter "subscriptionId" is set to "id"
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/Subscription"
    And the response property "$.id" is equal to "id"
    And the response property "$.config.subscriptionDetail.device" is not present

##################
# Error scenarios for management of input parameter device
##################

##################
# Error code 400
##################

##################
# Error code 401
##################

  @device_data_volume_subscriptions_retrieve_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    When the request "retrieveDeviceDataVolumeSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @device_data_volume_subscriptions_retrieve_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to a previously valid but now expired access token
    And the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    When the request "retrieveDeviceDataVolumeSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @device_data_volume_subscriptions_retrieve_401.3_malformed_access_token
  Scenario: Malformed access token
    Given the header "Authorization" is set to a malformed token
    And the request body is compliant with the schema "#/components/schemas/SubscriptionRequest"
    When the request "retrieveDeviceDataVolumeSubscription" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

##################
# Error code 403
##################

##################
# Error code 404
##################

  @device_data_volume_subscriptions_404.1_retrieve_unknown_subscription_id
  Scenario: Get subscription when subscriptionId is unknown to the system
    Given that there is no valid subscription with "subscriptionId" equal to "id"
    When the request "retrieveDeviceDataVolumeSubscription" is sent
    And the path parameter "subscriptionId" is equal to "id"
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

##################
# Error code 422
##################

    And the response property "$.code" is "MULTIEVENT_SUBSCRIPTION_NOT_SUPPORTED"
    And the response property "$.message" contains a user friendly text
