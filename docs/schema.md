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


