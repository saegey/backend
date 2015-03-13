## Overview

The platform API empowers developers to build manage your fobless account. You can use the platform API to programmatically create users, properties, property units, guests and accounts. For details on getting started, see Getting Started with the Platform API.

### Authentication

OAuth should be used to authorize and revoke access to your account to yourself and third parties. Details can be found in the OAuth article.

For personal scripts you may also use HTTP bearer authentication, but OAuth is recommended for any third party services. HTTP bearer authentication must be constructed using an API token, passed as the Authorization header for each request, for example `Authorization: Bearer 01234567-89ab-cdef-0123-456789abcdef`.

### Caching

All responses include an `ETag` (or Entity Tag) header, identifying the specific version of a returned resource. You may use this value to check for changes to a resource by repeating the request and passing the `ETag` value in the `If-None-Match` header. If the resource has not changed, a `304 Not Modified` status will be returned with an empty body. If the resource has changed, the request will proceed normally.

### Clients

Clients must address requests to `api.fobless.com` using HTTPS and specify the `Accept: application/vnd.fobless+json; version=1` Accept header. Clients should specify a `User-Agent` header to facilitate tracking and debugging.

### Caching

All responses include an `ETag` (or Entity Tag) header, identifying the specific version of a returned resource. You may use this value to check for changes to a resource by repeating the request and passing the `ETag` value in the `If-None-Match header`. If the resource has not changed, a `304 Not Modified` status will be returned with an empty body. If the resource has changed, the request will proceed normally.

### CORS

The Platform API supports cross-origin resource sharing (CORS) so that requests can be sent from browsers using JavaScript served from any domain.


### Schema

The API has a machine-readable [JSON schema](http://json-schema.org/) that describes what resources are available via the API, what their URLs are, how they are represented and what operations they support. You can access the schema using cURL:

```
$ curl https://api.fobless.com/schema \
-H "Accept: application/vnd.fobless+json; version=3"
```

```
{
  "description": "The platform API empowers developers to automate, extend and combine fobless with other services.",
  "definitions": {
  ...
  }
}
```

### Ranges

List requests will return a `Content-Range` header indicating the range of values returned. Large lists may require additional requests to retrieve. If a list response has been truncated you will receive a `206 Partial Content` status and the `Next-Range` header set. To retrieve the next range, repeat the request with the `Range` header set to the value of the previous request’s `Next-Range` header.

The number of values returned in a range can be controlled using a max key in the Range header. For example, to get only the first 10 values, set this header: Range: id ..; max=10;. max can also be passed when iterating over Next-Range. The default page size is 200 and maximum page size is 1000.

The property used to sort values in a list response can be changed. The default property is id, as in `Range: id ..;.` To learn what other properties you can use to sort a list response, inspect the Accept-Ranges headers. For the apps resource, for example, you can sort on either id or name:

```
$ curl -i -n -X GET https://api.fobless.com/apps \
-H "Accept: application/vnd.fobless+json; version=1"
```

```
...
Accept-Ranges: id, name
...
```

The default sort order for resource lists responses is ascending. You can opt for descending sort order by passing a order key in the range header:

```
$ curl -i -n -X GET https://api.fobless.com/apps \
-H "Accept: application/vnd.fobless+json; version=3" -H "Range: name ..; order=desc;"
```
Combining with the max key would look like this:
```
$ curl -i -n -X GET https://api.fobless.com/apps \
-H "Accept: application/vnd.fobless+json; version=1" \
-H "Range: name ..; order=desc,max=10;"
```

### HTTP Status Codes

Return appropriate HTTP status codes with each response. Successful
responses should be coded according to this guide:

* `200`: Request succeeded for a `GET` call, for a `DELETE` or
  `PATCH` call that completed synchronously, or for a `PUT` call that
  synchronously updated an existing resource
* `201`: Request succeeded for a `POST` call that completed
  synchronously, or for a `PUT` call that synchronously created a new
  resource
* `202`: Request accepted for a `POST`, `PUT`, `DELETE`, or `PATCH` call that
  will be processed asynchronously
* `206`: Request succeeded on `GET`, but only a partial response
  returned: see [above on ranges](#divide-large-responses-across-requests-with-ranges)

Pay attention to the use of authentication and authorization error codes:

* `401 Unauthorized`: Request failed because user is not authenticated
* `403 Forbidden`: Request failed because user does not have authorization to access a specific resource

Return suitable codes to provide additional information when there are errors:

* `422 Unprocessable Entity`: Your request was understood, but contained invalid parameters
* `429 Too Many Requests`: You have been rate-limited, retry later
* `500 Internal Server Error`: Something went wrong on the server, check status site and/or report the issue

Refer to the [HTTP response code spec](https://tools.ietf.org/html/rfc7231#section-6)
for guidance on status codes for user error and server error cases.



## Property_unit
FIXME

### Attributes
| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when property_unit was created | `"2012-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of property_unit | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **updated_at** | *date-time* | when property_unit was updated | `"2012-01-01T12:00:00Z"` |
### Property_unit Create
Create a new property_unit.

```
POST /property_units
```


#### Curl Example
```bash
$ curl -n -X POST https://fobless-backend.herokuapp.com/property_units \
  -H "Content-Type: application/json" \

```


#### Response Example
```
HTTP/1.1 201 Created
```
```json
{
  "created_at": "2012-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "updated_at": "2012-01-01T12:00:00Z"
}
```

### Property_unit Delete
Delete an existing property_unit.

```
DELETE /property_units/{property_unit_id}
```


#### Curl Example
```bash
$ curl -n -X DELETE https://fobless-backend.herokuapp.com/property_units/$PROPERTY_UNIT_ID \
  -H "Content-Type: application/json" \

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
{
  "created_at": "2012-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "updated_at": "2012-01-01T12:00:00Z"
}
```

### Property_unit Info
Info for existing property_unit.

```
GET /property_units/{property_unit_id}
```


#### Curl Example
```bash
$ curl -n -X GET https://fobless-backend.herokuapp.com/property_units/$PROPERTY_UNIT_ID

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
{
  "created_at": "2012-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "updated_at": "2012-01-01T12:00:00Z"
}
```

### Property_unit List
List existing property_units.

```
GET /property_units
```


#### Curl Example
```bash
$ curl -n -X GET https://fobless-backend.herokuapp.com/property_units

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
[
  {
    "created_at": "2012-01-01T12:00:00Z",
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "updated_at": "2012-01-01T12:00:00Z"
  }
]
```

### Property_unit Update
Update an existing property_unit.

```
PATCH /property_units/{property_unit_id}
```


#### Curl Example
```bash
$ curl -n -X PATCH https://fobless-backend.herokuapp.com/property_units/$PROPERTY_UNIT_ID \
  -H "Content-Type: application/json" \

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
{
  "created_at": "2012-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "updated_at": "2012-01-01T12:00:00Z"
}
```


## Property Unit Guests
This endpoint allows you to add guests to a property unit

### Attributes
| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when property unit guest was created | `"2012-01-01T12:00:00Z"` |
| **id** | *integer* | unique identifier of property_unit_guest | `1` |
| **pin_code** | *string* | guest pin code | `"12345"` |
| **phone_number** | *nullable string* | guest phone_number | `"+12223334444"` |
| **email** | *nullable string* | guest email address | `"guest@test.com"` |
| **updated_at** | *date-time* | when property_unit_guest was updated | `"2012-01-01T12:00:00Z"` |
### Property Unit Guests Create
Create a new property_unit_guest.

```
POST /property-unit-guests
```


#### Curl Example
```bash
$ curl -n -X POST https://fobless-backend.herokuapp.com/property-unit-guests \
  -H "Content-Type: application/json" \

```


#### Response Example
```
HTTP/1.1 201 Created
```
```json
{
  "created_at": "2012-01-01T12:00:00Z",
  "id": 1,
  "pin_code": "12345",
  "phone_number": "+12223334444",
  "email": "guest@test.com",
  "updated_at": "2012-01-01T12:00:00Z"
}
```

### Property Unit Guests Delete
Delete an existing property_unit_guest.

```
DELETE /property-unit-guests/{property_unit_guest_id}
```


#### Curl Example
```bash
$ curl -n -X DELETE https://fobless-backend.herokuapp.com/property-unit-guests/$PROPERTY_UNIT_GUEST_ID \
  -H "Content-Type: application/json" \

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
{
  "created_at": "2012-01-01T12:00:00Z",
  "id": 1,
  "pin_code": "12345",
  "phone_number": "+12223334444",
  "email": "guest@test.com",
  "updated_at": "2012-01-01T12:00:00Z"
}
```

### Property Unit Guests Info
Info for existing property_unit_guest.

```
GET /property-unit-guests/{property_unit_guest_id}
```


#### Curl Example
```bash
$ curl -n -X GET https://fobless-backend.herokuapp.com/property-unit-guests/$PROPERTY_UNIT_GUEST_ID

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
{
  "created_at": "2012-01-01T12:00:00Z",
  "id": 1,
  "pin_code": "12345",
  "phone_number": "+12223334444",
  "email": "guest@test.com",
  "updated_at": "2012-01-01T12:00:00Z"
}
```

### Property Unit Guests List
List existing property-unit-guests.

```
GET /property-unit-guests
```


#### Curl Example
```bash
$ curl -n -X GET https://fobless-backend.herokuapp.com/property-unit-guests

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
[
  {
    "created_at": "2012-01-01T12:00:00Z",
    "id": 1,
    "pin_code": "12345",
    "phone_number": "+12223334444",
    "email": "guest@test.com",
    "updated_at": "2012-01-01T12:00:00Z"
  }
]
```

### Property Unit Guests Update
Update an existing property_unit_guest.

```
PATCH /property-unit-guests/{property_unit_guest_id}
```


#### Curl Example
```bash
$ curl -n -X PATCH https://fobless-backend.herokuapp.com/property-unit-guests/$PROPERTY_UNIT_GUEST_ID \
  -H "Content-Type: application/json" \

```


#### Response Example
```
HTTP/1.1 200 OK
```
```json
{
  "created_at": "2012-01-01T12:00:00Z",
  "id": 1,
  "pin_code": "12345",
  "phone_number": "+12223334444",
  "email": "guest@test.com",
  "updated_at": "2012-01-01T12:00:00Z"
}
```


