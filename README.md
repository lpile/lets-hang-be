## Users Endpoints  
#### Create a user
**Request:**
```
POST /api/v1/users
Headers:
{Content-Type: application/json,
Accept: application/json}

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

#### Edit a user
**Request:**
```
PATCH /api/v1/users/:id
Headers:
{Content-Type: application/json,
Accept: application/json}

body:
{
  "first_name": "Update Name",
  "last_name": "Update Name",
  "phone_number": "3333333333",
  "email": "Update@email.com"
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
Headers:
{Content-Type: application/json,
Accept: application/json}

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

#### Get all events for user
**Request:**
```
GET api/vi/user/events?api_key=asD7fsdfwef2332!%sdf
Headers:
{Content-Type: application/json,
Accept: application/json}

** Note: api_key query params is required **
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
          "Location": "Denver,CO",
          "Creator": "Mike Will"
        },
        {
          "Title": "Stout",
          "Description": "All browsers support the hex definitions #chuck and #norris for the colors black and blue.",
          "Time": "2019-09-03T23:16:00.000Z",
          "Location": "Denver,CO",
          "Creator": "Mike Will"
        },
        {
          "Title": "Wood-aged Beer",
          "Description": "Chuck Norris' beard is immutable.",
          "Time": "2019-09-04T10:04:00.000Z",
          "Location": "Denver,CO",
          "Creator": "Mike Will"
        },
        {
          "Title": "Strong Ale",
          "Description": "No statement can catch the ChuckNorrisException.",
          "Time": "2019-09-04T07:30:00.000Z",
          "Location": "Denver,CO",
          "Creator": "Isidro Boehm"
        },
        {
          "Title": "Scottish And Irish Ale",
          "Description": "When a bug sees Chuck Norris, it flees screaming in terror, and then immediately self-destructs to avoid being roundhouse-kicked.",
          "Time": "2019-09-04T12:04:00.000Z",
          "Location": "Denver,CO",
          "Creator": "Thanh O'Conner"
        }
      ]
    }
  }
}
```

**Error:**
```
status: 404
body:
{
  "error"=>"Failed to find user"
}
```

#### Get all friends for user
**Request:**
```
GET api/vi/user/friends?api_key=asD7fsdfwef2332!%sdf
Headers:
{Content-Type: application/json,
Accept: application/json}

** Note: api_key query params is required **
```
**Response:**
```
status: 200
{
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "friends": [
        {
          "id": 2,
          "Name": "Abe Kshlerin",
          "Phone Number": "134.404.9791",
          "Email": "danette_roob@example.com"
        },
        {
          "id": 3,
          "Name": "Jamey Conroy",
          "Phone Number": "238-280-5410",
          "Email": "terrance@example.com"
        },
        {
          "id": 4,
          "Name": "Quintin Cruickshank",
          "Phone Number": "995.678.9202",
          "Email": "bobbi_hodkiewicz@example.com"
        },
        {
          "id": 5,
          "Name": "Billie Spinka",
          "Phone Number": "(833) 493-9944",
          "Email": "saundra.strosin@example.net"
        }
      ]
    }
  }
}
```

**Error:**
```
status: 404
body:
{
  "error"=>"Failed to find user"
}
```

#### Get all pending friends for user(current user who have requested other users to be friends)
**Request:**
```
GET api/vi/user/pending_friends?api_key=asD7fsdfwef2332!%sdf
Headers:
{Content-Type: application/json,
Accept: application/json}

** Note: api_key query params is required **
```
**Response:**
```
status: 200
{
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "friends": [
        {
          "id": 2,
          "Name": "Abe Kshlerin",
          "Phone Number": "134.404.9791",
          "Email": "danette_roob@example.com"
        },
        {
          "id": 3,
          "Name": "Jamey Conroy",
          "Phone Number": "238-280-5410",
          "Email": "terrance@example.com"
        }
      ]
    }
  }
}
```

**Error:**
```
status: 404
body:
{
  "error"=>"Failed to find user"
}
```

#### Get all requested friends for user(other users who have requested current user to be friends)
**Request:**
```
GET api/vi/user/requested_friends?api_key=asD7fsdfwef2332!%sdf
Headers:
{Content-Type: application/json,
Accept: application/json}

** Note: api_key query params is required **
```
**Response:**
```
status: 200
{
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "friends": [
        {
          "id": 4,
          "Name": "Quintin Cruickshank",
          "Phone Number": "995.678.9202",
          "Email": "bobbi_hodkiewicz@example.com"
        },
        {
          "id": 5,
          "Name": "Billie Spinka",
          "Phone Number": "(833) 493-9944",
          "Email": "saundra.strosin@example.net"
        }
      ]
    }
  }
}
```

**Error:**
```
status: 404
body:
{
  "error"=>"Failed to find user"
}
```

## Event Endpoints
#### Create a new event
**Request:**
```
POST /api/v1/events?api_key=asd!4gs?kSD
Headers:
{Content-Type: application/json,
Accept: application/json}

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
status: 201
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
  "error"=>"Failed to create event"
}
```

#### Get an event
**Request:**
```
GET api/vi/events/:event_id?api_key=asD7fsdfwef2332!%sdf
Headers:
{Content-Type: application/json,
Accept: application/json}

** Note: api_key query params is required **
```
**Response:**
```
status: 200
body:
{
  "data": {
    "id": "1",
    "type": "event",
    "attributes": {
      "title": "India Pale Ale",
      "description": "The only pattern Chuck Norris knows is God Object.",
      "creator": "Shirlee Rice",
      "event_location": "Arrogant Bastard Ale",
      "event_time": "07:57AM 09/04/19",
      "attendees": [
        "Shirlee Rice",
        "Ervin Gutmann",
        "Sergio Metz"
      ]
    }
  }
}
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
status: 404
body:
{
  "error"=>"Failed to find event"
}
```

#### Update an event
**Request:**
```
PATCH api/vi/events/:id?api_key=asd!4gs?kSD
Headers:
{Content-Type: application/json,
Accept: application/json}

body:
{
  "title": "Upated Happy Hour",
  "description": "Meet after school at Brothers",
  "event_time": "2019-09-04T07:05:00.000Z",
  "event_location": "Brothers"
}
```
**Response:**
```
status: 202
body:
{
  "data": {
    "id": "11",
    "type": "event",
    "attributes": {
      "title": "Updated Happy Hour",
      "description": "Meet after school at Brothers",
      "creator": "Mike Will",
      "event_location": "Brothers",
      "event_time": "01:05AM 09/04/19"
    }
  }
}
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
  "error"=>"Failed to update event"
}
```

## Friendship Endpoints
#### Friend request
**Request:**
```
POST /api/v1/friendships?api_key=<USER_API_KEY>&friend_id=<FRIEND_USER_ID>
Headers:
{Content-Type: application/json,
Accept: application/json}
```
**Response:**
```
status: 200
body:
{
  "data": {
    "id": "13",
    "type": "request",
    "attributes": {
      "requester": {
        "id": 3,
        "name": "Jamey Conroy",
        "status": "pending"
      },
      "requestee": {
        "id": 2,
        "name": "Abe Kshlerin",
        "status": "requested"
      }
    }
  }
}
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
status: 404
body:
{
  "error"=>"Failed to find friend"
}
```
#### Accept friend request
**Request:**
```
PATCH /api/v1/friendships/<REQUESTER_USER_ID>?api_key=<USER_API_KEY>
Headers:
{Content-Type: application/json,
Accept: application/json}
```
**Response:**
```
status: 200
body:
{
  "data": {
    "id": "14",
    "type": "accept",
    "attributes": {
      "requester": {
        "id": 3,
        "name": "Jamey Conroy",
        "status": "accepted"
      },
      "requestee": {
        "id": 2,
        "name": "Abe Kshlerin",
        "status": "accepted"
      }
    }
  }
}
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
status: 404
body:
{
  "error"=>"Failed to find requesting friend"
}
```
#### Decline friend request / remove friend
**Request:**
```
DELETE /api/v1/friendships/<REMOVE_USER_ID>?api_key=<USER_API_KEY>
Headers:
{Content-Type: application/json,
Accept: application/json}
```
**Response:**
```
status: 204
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
status: 404
body:
{
  "error"=>"Failed to find requesting friend"
}
```
