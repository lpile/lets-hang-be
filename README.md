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
status: 422
body:
{
  "error"=>"Failed to register"
}
```

#### Edit a single user
**Request:**
```
PATCH /api/v1/user/edit
Content-Type: application/json
Accept: application/json

body:
{
  "first_name": "Update Name",
  "last_name": "Update Name",
  "phone_number": "3333333333",
  "email": "Update@email.com",
  "api_key": "asD7fsdfwef2332!%sdf"
}

** Note: At least one field is required **
```
**Response:**
```
status: 202
body:
{
  "data":
  {
    "type": "user",
    "id": "1",
    "attributes":
    {
      "first_name": "Update Name",
      "last_name": "Update Name",
      "phone_number": "3333333333",
      "email": "Update@email.com",
      "api_key": "L4sw!sdg?KE364"
    }
  }
}

** Note: A new api key will be generated **
```

**Errors:**
```
status: 404
body:
{
  "error"=>"Failed to find user"
}
```
```
status: 422
body:
{
  "error"=>"Failed to update user"
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
status: 422
body:
{
  "error"=>"Failed to login"
}
```
### Friendship Endpoints

### Event Endpoints

#### Get all events for current user

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
```
{
  "error"=>"No events found"
}
```

#### Create a new event

**Request:**
```
POST api/vi/events?api_key=kljh34!3hjh4

Content-Type: application/json
Accept: application/json

Query Params: api_key (required)

body:
{
  "title": "Happy Hour",
  "description": "Meet after school at Brothers",
  "event_time": "2019-09-04T07:05:00.000Z",
  "event_location": "Brothers"
}
```
**Response:**
```
status code: 201

body: 
{
    "data": {
        "id": "11",
        "type": "event",
        "attributes": {
            "title": "Happy Hour",
            "description": "Meet after school at Brothers",
            "creator": "Mike Will",
            "event_location": "Brothers",
            "event_time": "01:05AM 09/04/19"
        }
    }
}
```

**Error:**
```
{
  "error"=>"Failed to create event"
}
```