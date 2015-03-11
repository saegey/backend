## Property_unit_guest
FIXME

### Attributes
| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when property_unit_guest was created | `"2012-01-01T12:00:00Z"` |
| **id** | *integer* | unique identifier of property_unit_guest | `1` |
| **pin_code** | *string* | guest pin code | `"12345"` |
| **phone_number** | *nullable string* | guest phone_number | `"+12223334444"` |
| **email** | *nullable string* | guest email address | `"guest@test.com"` |
| **updated_at** | *date-time* | when property_unit_guest was updated | `"2012-01-01T12:00:00Z"` |
### Property_unit_guest Create
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

### Property_unit_guest Delete
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

### Property_unit_guest Info
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

### Property_unit_guest List
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

### Property_unit_guest Update
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


