# Changelog DeviceDataVolume

<!-- TOC:START -->
## Table of Contents
- [r2.1](#r21)
<!-- TOC:END -->

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

# r2.1

## Release Notes

This release candidate contains the definition and documentation of
* device-data-volume-subscriptions 0.2.0-rc.1
* device-data-volume 0.2.0-rc.1

The API definition(s) are based on
* Commonalities r4.4 (0.9.0)
* Identity and Consent Management r4.2 (0.5.0)

## device-data-volume-subscriptions 0.2.0-rc.1

**device-data-volume-subscriptions 0.2.0-rc.1 is a release-candidate version of this API.**

Changes documented below are compared to version 0.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r2.1/code/API_definitions/device-data-volume-subscriptions.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r2.1/code/API_definitions/device-data-volume-subscriptions.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceDataVolume/blob/r2.1/code/API_definitions/device-data-volume-subscriptions.yaml)

### Breaking changes

* Update API definitions to fix CAMARA validation warnings and hints by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/81
  - Pagination for listing of subscriptions using GET /subscriptions is now supported
    -  Addition of `page` and `perPage` query parameters to control pagination
    -  Returned subscriptions are now embedded in the array `subscriptions` within the response JSON, with the page tracked within the `pagination` JSON
    -  Addition of response headers `X-Total-Count`, `X-Total-Pages` and `Link` to facilitate page navigation
* [Changed, Breaking] Rename data allowance consumption events for clarity by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/106
  - Data allowance consumption events renamed for clarity:
    - org.camaraproject.device-data-volume-subscriptions.v0.data-50-percent-remaining: Event triggered when only 50% of the data plan is remaining
    - org.camaraproject.device-data-volume-subscriptions.v0.data-25-percent-remaining: Event triggered when only 25% of the data plan is remaining
    - org.camaraproject.device-data-volume-subscriptions.v0.data-10-percent-remaining: Event triggered when only 10% of the data plan is remaining
    - org.camaraproject.device-data-volume-subscriptions.v0.data-00-percent-remaining: Event triggered when the data plan is fully consumed

### Added

* [Added] Add additional device data volume status subscription list scenarios and move to separate feature file by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/103

### Changed

* Update API definitions to fix CAMARA validation warnings and hints by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/81
* [Changed, Breaking] Rename data allowance consumption events for clarity by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/106
* [Changed] Refactor subscription schemas for Commonalities r4.4 and add initialEvent by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/113

### Fixed

* [Fixed] Documentation fixes for Sync26 by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/104
* [Fix] Correct feature file name and event names / schemas within feature files by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/110
* [Fixed] Update subscriptionDetail reference in YAML file by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/114

### Removed

* N/A

## device-data-volume 0.2.0-rc.1

**device-data-volume 0.2.0-rc.1 is a release-candidate version of this API.**

Changes documented below are compared to version 0.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r2.1/code/API_definitions/device-data-volume.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/DeviceDataVolume/r2.1/code/API_definitions/device-data-volume.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/DeviceDataVolume/blob/r2.1/code/API_definitions/device-data-volume.yaml)

### Breaking changes

* [Changed, Breaking] Refactor device-data-volume to return data volumes rather than categories, and use MB/GB instead of MiB/GiB by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/107
  - Refactor device-data-volume for simpler and more intuitive behaviour:
    - Use MB/GB instead of MiB/GiB for data allowances
    - Return remaining data allowance rather than data allowance category, allowing "Unlimited" as a response option
    - Rename properties for clarity:
      - Request property `volumeToCheck` becomes `dataAllowanceThreshold`
      - Response property `dataVolumeCategory` becomes `remainingDataAllowance`

### Added

* [Added] Add lastStatusTime field to successful responses with examples by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/89
* [Added] Update happy path tests to include validation of lastStatusTime property by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/97

### Changed

* Update API definitions to fix CAMARA validation warnings and hints by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/81
* [Changed, Breaking] Refactor device-data-volume to return data volumes rather than categories, and use MB/GB instead of MiB/GiB by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/107

### Fixed

* [Fixed] Documentation fixes for Sync26 by @eric-murray in https://github.com/camaraproject/DeviceDataVolume/pull/104

### Removed

* N/A

**Full Changelog**: https://github.com/camaraproject/DeviceDataVolume/compare/r1.3...r2.1

