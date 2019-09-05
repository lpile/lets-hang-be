### User Endpoints  

#### Create a single user
**Request:**
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

body:
{
  "first_name": "First Name",
  "last_name": "Last Name",
  "phone_number": "3033033030",
  "email": "Name@email.com",
  "password": "password",
  "password_confirmation": "password"
}
```
**Response:**
```
status: 201
body:
{
  "data":
  {
    "type": "user",
    "id": "1",
    "attributes":
    {
      "first_name": "First Name",
      "last_name": "Last Name",
      "phone_number": "3033033030",
      "email": "FirstLast@email.com",
      "api_key": "asD7fsdfwef2332!%sdf"
    }
  }
}
```
**Error:**
```
{
  "error"=>"Failed to login"
}
```

#### User login
**Request:**
```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

body:
{
  "email": "Name@email.com",
  "password": "password"
}
```
**Response:**
```
status: 200
body:
{
  "data":
  {
    "type": "user",
    "id": "1",
    "attributes":
    {
      "first_name": "First Name",
      "last_name": "Last Name",
      "phone_number": "3033033030",
      "email": "FirstLast@email.com",
      "api_key": "asD7fsdfwef2332!%sdf"
    }
  }
}
```
**Error:**
```
{
  "error"=>"Failed to login"
}
```
### Friendship Endpoints

### Event Endpoints

## Get all events for current user

**Request:**
```
GET api/vi/events

Headers: 
Content-Type: application/json
Accept: application/json

Query Params: api_key
```
**Response:**
```
status: 200
body: 
{
    "data": {
        "id": "4",
        "type": "user",
        "attributes": {
            "events": [
                {
                    "Title": "Sour Ale",
                    "Description": "Chuck Norris doesn't need a debugger, he just stares down the bug until the code confesses.",
                    "Time": "2019-09-04T07:05:00.000Z",
                    "Location": null,
                    "Creator": "Mike Will"
                },
                {
                    "Title": "Stout",
                    "Description": "All browsers support the hex definitions #chuck and #norris for the colors black and blue.",
                    "Time": "2019-09-03T23:16:00.000Z",
                    "Location": null,
                    "Creator": "Mike Will"
                },
                {
                    "Title": "Wood-aged Beer",
                    "Description": "Chuck Norris' beard is immutable.",
                    "Time": "2019-09-04T10:04:00.000Z",
                    "Location": null,
                    "Creator": "Mike Will"
                },
                {
                    "Title": "Strong Ale",
                    "Description": "No statement can catch the ChuckNorrisException.",
                    "Time": "2019-09-04T07:30:00.000Z",
                    "Location": null,
                    "Creator": "Isidro Boehm"
                },
                {
                    "Title": "Scottish And Irish Ale",
                    "Description": "When a bug sees Chuck Norris, it flees screaming in terror, and then immediately self-destructs to avoid being roundhouse-kicked.",
                    "Time": "2019-09-04T12:04:00.000Z",
                    "Location": null,
                    "Creator": "Thanh O'Conner"
                }
            ]
        }
    }
}
```

**Error:**
<!-- NEED TO ADD ERROR MESSAGE FOR UNSUCCESSFUL GET USER EVENTS GET -->

## Create a new event

**Request:**
```
POST api/vi/events

Content-Type: application/json
Accept: application/json

body:
{
  "title": "Happy Hour",
  "description": "Meet after school at Brothers",
  "event_time": "4:00PM",
  "event_location": "Brothers",
  "creator": "Mike Will"
}
```
**Response:**
```
status code: 201

body: 
```
<!-- ADD BODY OF RESPONSE ONCE CONTROLLER COMPLETE -->
