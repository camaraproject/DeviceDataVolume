# Changelog DeviceDataVolume

## Table of Contents
- **[r1.2](#r12)**
- [r1.1](#r11)

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

# r1.2

## Release Notes

This release contains the definition and documentation of
* device-data-volume v0.1.0-rc.1
* device-data-volume-subscriptions v0.1.0-rc.1

The API definition(s) are based on
* Commonalities 0.6
* Identity and Consent Management 0.4

## device-data-volume v0.1.0-rc.1

**device-data-volume v0.1.0-rc.1 is the first release-candidate of the DeviceDataVolume API v0.1.0**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r1.2/code/API_definitions/device-data-volume.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r1.2/code/API_definitions/device-data-volume.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceDataVolume/blob/r1.2/code/API_definitions/device-data-volume.yaml)

### Added
* Basic test specifications for both Device Data Volume and its Subscription by @sachinvodafone in https://github.com/camaraproject/DeviceDataVolume/pull/13
* Add response-component for `/check` - API incl. `thresholdExceeded` as property by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/33
* Add gherkin-linting and update links in config by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/37 
* Documented Error Responses info.description section by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/47

### Changed
* Reset version to wip following alpha release by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/17
* Update error codes and format by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/19
* Alignment with Commonalities 0.5 by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/28
* Update test-scenarios for device-data-volume- and subscription - APIs by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/34
* Mark `device` as optional by adding support for 3-legged token by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/35
* Update OAS and test definitions to remove IDENTIFIER_MISMATCH error code by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/52
* Update `x-correlator` pattern by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/49


### Removed
* Remove AUTHENTICATION_REQUIRED error code by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/40

## device-data-volume-subscriptions v0.1.0-rc.1

**device-data-volume-subscriptions v0.1.0-rc.1 is the first release-candidate of the DeviceDataVolume-Subscriptions API v0.1.0**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r1.2/code/API_definitions/device-data-volume-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r1.2/code/API_definitions/device-data-volume-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceDataVolume/blob/r1.2/code/API_definitions/device-data-volume-subscriptions.yaml)

### Added
* Basic test specifications for both Device Data Volume and Its Subscription by @sachinvodafone in https://github.com/camaraproject/DeviceDataVolume/pull/13
* Add gherkin-linting and update links in config by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/37
* Documented Error Responses info.description section by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/47

### Changed
* Reset version to wip following alpha release by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/17
* Update error codes and format by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/19
* Alignment with Commonalities 0.5 by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/28
* Update test-scenarios for device-data-volume- and subscription - APIs by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/34
* Mark `device` as optional by adding support for 3-legged token by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/35
* Update OAS and test definitions to remove IDENTIFIER_MISMATCH error code by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/52
* Update the `sink` - pattern and set `id` in `SubscriptionAsync` to mandatory by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/61
* [data-volume-subscriptions]: update `subscription-ends` to `subscription-ended` and add `subscription-started` and `subscription-updated` by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/56
* Update `x-correlator` pattern by @maxl2287 in https://github.com/camaraproject/DeviceDataVolume/pull/49

### Fixed
* Add missing components and update Subscription types array items by @dfischer-tech in https://github.com/camaraproject/DeviceDataVolume/pull/24

### Removed
* Remove allof in sinkcredential by @ravindrapalaskar17 in https://github.com/camaraproject/DeviceDataVolume/pull/27
* Remove AUTHENTICATION_REQUIRED error code by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/40

## New Contributors
* @maxl2287 made their first contribution in https://github.com/camaraproject/DeviceDataVolume/pull/19
* @sachinvodafone made their first contribution in https://github.com/camaraproject/DeviceDataVolume/pull/13
* @dfischer-tech made their first contribution in https://github.com/camaraproject/DeviceDataVolume/pull/24
* @ravindrapalaskar17 made their first contribution in https://github.com/camaraproject/DeviceDataVolume/pull/27
* @hdamker-bot made their first contribution in https://github.com/camaraproject/DeviceDataVolume/pull/45

**Full Changelog**: https://github.com/camaraproject/DeviceDataVolume/compare/r1.1...r1.2

# r1.1
## Release Notes

This pre-release contains the definition and documentation of:
* device-data-volume v0.1.0-alpha.1
* device-data-volume-subscriptions v0.1.0-alpha.1

## device-data-volume v0.1.0-alpha.1

**device-data-volume v0.1.0-alpha.1 is the first alpha-release of the DeviceDataVolume API v0.1.0**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r1.1/code/API_definitions/device-data-volume.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r1.1/code/API_definitions/device-data-volume.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceDataVolume/blob/r1.1/code/API_definitions/device-data-volume.yaml)

### Added
* First alpha version of device-data-volume.yaml provided by @VijayKesharwani

## device-data-volume-subscriptions v0.1.0-alpha.1

**device-data-volume-subscriptions v0.1.0-alpha.1 is the first alpha-release of the API**

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r1.1/code/API_definitions/device-data-volume-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r1.1/code/API_definitions/device-data-volume-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceDataVolume/blob/r1.1/code/API_definitions/device-data-volume-subscriptions.yaml)

### Added
* First version of device-data-volume-subscriptions.yaml provided by @VijayKesharwani

**Full Changelog**: https://github.com/camaraproject/DeviceDataVolume/commits/r1.1
