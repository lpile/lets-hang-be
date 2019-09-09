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
  "phone_number": "9999999999",
  "email": "FirstLast@email.com",
  "password": "password",
  "password_confirmation": "password"
}
```
**Response:**
```
status: 201
body:
{
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "first_name": "First Name",
      "last_name": "Last Name",
      "phone_number": "9999999999",
      "email": "FirstLast@email.com",
      "api_key": "8d5340cf0f6edca1f69d"
    }
  }
}
```
**Error:**
```
status: 422
body:
{
  "error": "Failed to register"
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
  "email": "FirstLast@email.com",
  "password": "password"
}
```
**Response:**
```
status: 200
body:
{
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "first_name": "First Name",
      "last_name": "Last Name",
      "phone_number": "9999999999",
      "email": "FirstLast@email.com",
      "api_key": "8d5340cf0f6edca1f69d"
    }
  }
}
```
**Error:**
```
status: 422
body:
{
  "error": "Failed to login"
}
```

#### Edit a user
**Request:**
```
PATCH /api/v1/users/:id?api_key=8d5340cf0f6edca1f69d
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

** Note: api_key query params is required **
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
  "error": "Failed to find user"
}
```
```
status: 422
body:
{
  "error": "Failed to update user"
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
    "id": "1",
    "type": "user",
    "attributes": {
      "events": [
        {
          "id": 1,
          "Title": "Event 1",
          "Description": "description",
          "Time": "04:03PM 09/09/19",
          "Location": "Denver, CO",
          "Creator": "User 1"
        },
        {
          "id": 2,
          "Title": "Event 2",
          "Description": "description",
          "Time": "04:03PM 09/11/19",
          "Location": "Denver, CO",
          "Creator": "User 1"
        },
        {
          "id": 3,
          "Title": "Event 3",
          "Description": "description",
          "Time": "04:03PM 09/09/19",
          "Location": "Denver, CO",
          "Creator": "User 2"
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
  "error": "Failed to find user"
}
```

#### Get all friends for user
**Request:**
```
GET api/vi/user/friends?api_key=c3f11ecd0c277a63ddf4
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
      "accepted_friends": [
        {
          "id": 2,
          "Name": "User 2",
          "Phone Number": "2222222222",
          "Email": "User2@email.com"
        },
        {
          "id": 3,
          "Name": "User 3",
          "Phone Number": "3333333333",
          "Email": "User3@email.com"
        }
      ],
      "pending_friends": [
        {
          "id": 4,
          "Name": "User 4",
          "Phone Number": "4444444444",
          "Email": "User4@email.com"
        }
      ],
      "requested_friends": [
        {
          "id": 5,
          "Name": "User 5",
          "Phone Number": "5555555555",
          "Email": "User5@email.com"
        }
      ]
    }
  }
}

** Note: Pending friend is when the current user request another user to be friends **
** Note: Requested friend is when another user requests the current user to be friends **
```
**Error:**
```
status: 404
body:
{
  "error": "Failed to find user"
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
    "id": "4",
    "type": "event",
    "attributes": {
      "title": "Happy Hour",
      "description": "Meet after school at Brothers",
      "creator": "User 1",
      "event_location": "Denver, CO",
      "event_time": "01:05AM 09/04/19",
      "attendees": [
        "User 1"
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
  "error": "Failed to find user"
}
```
```
status: 422
body:
{
  "error": "Failed to create event"
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
      "title": "Event 1",
      "description": "description",
      "creator": "User 1",
      "event_location": "Denver, CO",
      "event_time": "04:03PM 09/09/19",
      "attendees": [
        "User 1",
        "User 2",
        "User 3",
        "User 4",
        "User 5"
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
  "error": "Failed to find user"
}
```
```
status: 404
body:
{
  "error": "Failed to find event"
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
  "title": "Update Title",
  "description": "Update Description",
  "event_time": "2019-09-04T07:05:00.000Z",
  "event_location": "Aurora, CO"
}
```
**Response:**
```
status: 202
body:
{
  "data": {
    "id": "1",
    "type": "event",
    "attributes": {
      "title": "Update Title",
      "description": "Update Description",
      "creator": "User 1",
      "event_location": "Aurora, CO",
      "event_time": "01:05AM 09/04/19",
      "attendees": [
        "User 1",
        "User 2",
        "User 3",
        "User 4",
        "User 5"
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
  "error": "Failed to find user"
}
```
```
status: 404
body:
{
  "error": "Failed to find event"
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
