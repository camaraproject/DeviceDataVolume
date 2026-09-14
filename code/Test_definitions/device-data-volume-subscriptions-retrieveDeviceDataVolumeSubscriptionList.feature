# device-data-volume-subscriptions-retrieveDeviceDataVolumeSubscriptionList
Feature: Device Data Volume Subscriptions API, vwip - Operation retrieveDeviceDataVolumeSubscriptionList

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

  Background: Common Device Data Volume Subscriptions setup
    Given the resource "{apiroot}/device-data-volume-subscriptions/vwip/subscriptions" as base-url
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"

##########################
# Happy path scenarios
##########################

  @device_data_volume_subscriptions_01_operation_to_retrieve_list_of_subscriptions_2legs
  Scenario: Get a list of subscriptions for a 2-legged access token
    Given an API consumer that has created at least one device data volume status subscription
    And the header "Authorization" is set to a valid access token which does not identify any device
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionList"
    And each item in the response body array "$.subscriptions" complies with the OAS schema at "#/components/schemas/Subscription"
    And the response body array "$.subscriptions" includes all subscriptions created by the API consumer
    And the response body array "$.subscriptions" does not include any subscriptions created by a different API consumer
    And the response body property "$.pagination" complies with the OAS schema at "#/components/schemas/Pagination"

  @device_data_volume_subscriptions_02_operation_to_retrieve_list_of_subscriptions_3legs
  Scenario: Get a list of subscriptions for a 3-legged access token
    Given an API consumer that has created at least one device data volume status subscription for a given device
    And the header "Authorization" is set to a valid access token which identifies that device
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionList"
    And each item in the response body array "$.subscriptions" complies with the OAS schema at "#/components/schemas/Subscription"
    And the response body array "$.subscriptions" includes all subscriptions created by the API consumer for the identified device
    And the response body array "$.subscriptions" does not include any subscriptions created by the API consumer for a different device
    And the response body array "$.subscriptions" does not include any subscriptions created by a different API consumer
    And the response body property "$.subscriptions[*].config.subscriptionDetail.device" is not present for any of the subscription records
    And the response body property "$.pagination" complies with the OAS schema at "#/components/schemas/Pagination"

  @device_data_volume_subscriptions_03_operation_to_retrieve_list_of_subscriptions_when_no_records
  Scenario: Get a list of device data volume status subscriptions when no subscriptions are available
    Given an API consumer that has created no device data volume status subscriptions
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionList"
    And the response body array "$.subscriptions" is an empty array
    And the response body property "$.pagination" complies with the OAS schema at "#/components/schemas/Pagination"

  @device_data_volume_subscriptions_04_pagination_default_values
  Scenario: Subscription list pagination with default values for page and perPage
    Given an API consumer who has created more than 20 device data volume status subscriptions
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent without setting query parameters "page" and "perPage"
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response header "Link" contains a link to the next page with rel="next"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionList"
    And the response body array "$.subscriptions" has 20 items and each item complies with the OAS schema at "#/components/schemas/Subscription"
    And the response body property "$.pagination" complies with the OAS schema at "#/components/schemas/Pagination"
    And the response body property "$.pagination.page" is 1
    And the response body property "$.pagination.perPage" is 20

  @device_data_volume_subscriptions_05_pagination_custom_values
  Scenario: Subscription list pagination with custom values for page and perPage
    Given an API consumer who has created more than 40 device data volume status subscriptions
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent with query parameters "page" set to 1 and "perPage" set to 20
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response header "Link" contains a link to the next page with rel="next"
    And the response header "X-Total-Pages" is equal to the value of the response body property "$.pagination.totalPages"
    And the response header "X-Total-Count" is equal to the value of the response body property "$.pagination.totalCount"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionList"
    And the response body array "$.subscriptions" has 20 items and each item complies with the OAS schema at "#/components/schemas/Subscription"
    And the response body property "$.pagination" complies with the OAS schema at "#/components/schemas/Pagination"
    And the response body property "$.pagination.page" is 1
    And the response body property "$.pagination.perPage" is 20
    And the response body property "$.pagination.totalPages", if present, is greater than 2
    And the response body property "$.pagination.totalCount", if present, is greater than 40

  @device_data_volume_subscriptions_06_pagination_middle_page
  Scenario: Subscription list pagination fetching a middle page of the list
    Given an API consumer who has created more than 40 device data volume status subscriptions
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent with query parameters "page" set to 2 and "perPage" set to 20
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response header "Link" contains a link to the previous page with rel="prev" and a link to the next page with rel="next"
    And the response header "X-Total-Pages" is equal to the value of the response body property "$.pagination.totalPages"
    And the response header "X-Total-Count" is equal to the value of the response body property "$.pagination.totalCount"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionList"
    And the response body array "$.subscriptions" has 20 items and each item complies with the OAS schema at "#/components/schemas/Subscription"
    And the response body property "$.pagination" complies with the OAS schema at "#/components/schemas/Pagination"
    And the response body property "$.pagination.page" is 2
    And the response body property "$.pagination.perPage" is 20
    And the response body property "$.pagination.totalPages", if present, is greater than 2
    And the response body property "$.pagination.totalCount", if present, is greater than 40

  @device_data_volume_subscriptions_07_pagination_last_page
  Scenario: Subscription list pagination fetching the last page of the list
    Given an API consumer who has created more than 40 and less than 60 device data volume status subscriptions
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent with query parameters "page" set to 3 and "perPage" set to 20
    Then the response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response header "Link" contains a link to the previous page with rel="prev"
    And the response header "X-Total-Pages" is equal to the value of the response body property "$.pagination.totalPages"
    And the response header "X-Total-Count" is equal to the value of the response body property "$.pagination.totalCount"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionList"
    And the response body array "$.subscriptions" has between 1 and 20 items and each item complies with the OAS schema at "#/components/schemas/Subscription"
    And the response body property "$.pagination" complies with the OAS schema at "#/components/schemas/Pagination"
    And the response body property "$.pagination.page" is 3
    And the response body property "$.pagination.perPage" is 20
    And the response body property "$.pagination.totalPages", if present, is 3
    And the response body property "$.pagination.totalCount", if present, is greater than 40 and less than 60

##################
# Error code 400
##################

  @device_data_volume_subscriptions_retrieve_list_400.01_pagination_invalid_page_parameter
  Scenario: Subscription list pagination with invalid value for page parameter
    Given an API consumer who has created more than 20 device data volume status subscriptions
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent with query parameter "page" set to any value less than 1 and "perPage" set to 20
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @device_data_volume_subscriptions_retrieve_list_400.02_pagination_invalid_perPage_parameter
  Scenario: Subscription list pagination with invalid value for perPage parameter
    Given an API consumer who has created more than 20 device data volume status subscriptions
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent with query parameter "page" set to 1 and "perPage" set to any value outside the range [1-100]
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

##################
# Error code 401
##################

  @device_data_volume_subscriptions_retrieve_list_401.01_no_authorization_header
  Scenario: No Authorization header
    Given the request header "Authorization" is removed
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @device_data_volume_subscriptions_retrieve_list_401.02_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to a previously valid but now expired access token
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @device_data_volume_subscriptions_retrieve_list_401.03_malformed_access_token
  Scenario: Malformed access token
    Given the header "Authorization" is set to a malformed token
    When the request "retrieveDeviceDataVolumeSubscriptionList" is sent
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

##################
# Error code 422
##################
