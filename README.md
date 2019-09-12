Lets Hang API
=============

Welcome to Lets Hang API! This is an API that serves as the backend for _Lets-Hang_, built by [Anneke McGrady](https://github.com/annekemcgrady/) and [Logan Pile](https://github.com/lpile/). The _Lets-Hang_ frontend is viewable on GitHub [here](https://github.com/kaylalarson1990/Lets-Hang), built by [Ryan Flachman](https://github.com/flachman03) and [Kayla Larson](https://github.com/kaylalarson1990).

[Deployed Site](https://lets-hang-be.herokuapp.com/)

Table of Contents
=================
##### [Schema](#schema)
##### [About](#about)
##### [User Endpoints](#user-endpoints)
  * [Create An User](#create-an-user)
  * [Login An User](#login-an-user)
  * [Update An User](#update-an-user)
  * [Get All Events Associated With User](#get-all-events-associated-with-user)
  * [Get All Friends Associated With User](#get-all-friends-associated-with-user)
  * [User Can Search For Friend](#user-can-search-for-friend)

##### [Event Endpoints](#event-endpoints)
  * [Create An Event](#create-an-event)
  * [Show An Event](#show-an-event)
  * [Update An Event](#update-an-event)
  * [Invite A Friend To Event](#invite-a-friend-to-event)
  * [User Can Decline Event Invite](#user-can-decline-event-invite)
  * [User Can Accept Event Invite](#user-can-accept-event-invite)

##### [Friendship Endpoints](#friendship-endpoints)
  * [Send Friend Request](#send-friend-request)
  * [Accept Friend Request](#accept-friend-request)
  * [Decline Friend Request Or Remove Friend](#decline-friend-request-or-remove-friend)

##### [Local Installation](#local-installation)
  * [Requirements](#requirements)
  * [Setup](#setup)
  * [Testing](#testing)


About
=====
Finding friends who wants to hang out in the moment can be hard for someone with a busy schedule. Well Lets-Hang allows people to schedule events in real time and add any of your friends to your created events.

Schema
======
![Lets Hang API Schema](/public/schema.png)

User Endpoints
==============

Create An User
-------------
**Request**
```
POST https://lets-hang-be.herokuapp.com/api/v1/users
```
**Request Body**
```
{
  "first_name": "First Name",
  "last_name": "Last Name",
  "phone_number": "9999999999",
  "email": "FirstLast@email.com",
  "password": "password",
  "password_confirmation": "password"
}
```
**Response Body**
```
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

Login An User
-------------
**Request**
```
POST https://lets-hang-be.herokuapp.com/api/v1/sessions
```
**Request Body**
```
{
  "email": "FirstLast@email.com",
  "password": "password"
}
```
**Response Body**
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

Update An User
--------------
**Request**
```
PATCH https://lets-hang-be.herokuapp.com/api/v1/users/{USER_ID}
```
**Parameters**
```
api_key=<USER_API_KEY>
```
**Request Body**
```
{
  "first_name": "Update Name",
  "last_name": "Update Name",
  "phone_number": "3333333333",
  "email": "Update@email.com"
}

```
**Response Body**
```
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

```
Get All Events Associated With User
-----------------------------------
**Request**
```
GET https://lets-hang-be.herokuapp.com/api/vi/user/events
```
**Parameters**
```
api_key=<USER_API_KEY>
```
**Response Body**
```
{
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "events": [
        {
          "id": 1,
          "title": "Event 1",
          "description": "description",
          "event_time": "whenever",
          "event_location": "Denver, CO",
          "creator": "User 1"
        },
        {
          "id": 2,
          "title": "Event 2",
          "description": "description",
          "event_time": "Tonight at 9pm",
          "event_location": "Denver, CO",
          "creator": "User 1"
        },
        {
          "id": 3,
          "title": "Event 3",
          "description": "description",
          "event_time": "Right now",
          "event_location": "Denver, CO",
          "creator": "User 2"
        }
      ]
    }
  }
}
```

Get All Friends Associated With User
------------------------------------
**Request**
```
GET https://lets-hang-be.herokuapp.com/api/vi/user/friends
```
**Parameters**
```
api_key=<USER_API_KEY>
```
**Response Body**
```
{
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "accepted_friends": [
        {
          "id": 2,
          "name": "User 2",
          "phone_number": "2222222222",
          "email": "User2@email.com"
        },
        {
          "id": 3,
          "name": "User 3",
          "phone_number": "3333333333",
          "email": "User3@email.com"
        }
      ],
      "pending_friends": [
        {
          "id": 4,
          "name": "User 4",
          "phone_number": "4444444444",
          "email": "User4@email.com"
        }
      ],
      "requested_friends": [
        {
          "id": 5,
          "name": "User 5",
          "phone_number": "5555555555",
          "email": "User5@email.com"
        }
      ]
    }
  }
}

** Note: Pending friend is when the current user request another user to be friends **
** Note: Requested friend is when another user requests the current user to be friends **
```

User Can Search For Friend
--------------------------
**Request**
```
GET https://lets-hang-be.herokuapp.com/api/v1/user/search
```
**Parameters**
```
api_key=<USER_API_KEY>
query=<string of friend's name>
```
**Response Body**
```
{
  "data": {
    "id": "10",
    "type": "search_friend",
    "attributes": {
      "name": "User 2",
      "phone_number": "2222222222",
      "email": "User2@email.com"
    }
  }
}
```

Event Endpoints
===============

Create An Event
---------------
**Request**
```
POST https://lets-hang-be.herokuapp.com/api/v1/events
```
**Parameters**
```
api_key=<USER_API_KEY>
```
**Request Body**
```
{
  "title": "Happy Hour",
  "description": "Meet after school at Brothers",
  "event_time": "2019-09-04T07:05:00.000Z",
  "event_location": "Brothers"
}
```
**Response Body**
```
{
  "data": {
    "id": "1",
    "type": "event",
    "attributes": {
      "title": "Happy Hour",
      "description": "Meet after school at Brothers",
      "creator": "User 1",
      "event_time": "Around 4pm",
      "event_location": "Denver, CO",
      "invited": [],
      "accepted": [
      {
        "id": 1,
        "name": "User 1"
      }
      ],
      "declined": []
    }
  }
}
```

Show An Event
-------------
**Request**
```
GET https://lets-hang-be.herokuapp.com/api/vi/events/{EVENT_ID}
```
**Parameters**
```
api_key=<USER_API_KEY>
```
**Response Body**
```
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
      "invited": [
      {
      "id": 2,
      "name": "User 2"
      },
      {
        "id": 3,
        "name": "User 3"
      }
      ],
      "accepted": [
      {
        "id": 1,
        "name": "User 1"
      }
      ],
      "declined": [
      {
        "id": 4,
        "name": "User 4"
      }
      ]
    }
  }
}
```

Update An Event
---------------
**Request**
```
PATCH https://lets-hang-be.herokuapp.com/api/vi/events/{EVENT_ID}
```
**Parameters**
```
api_key=<USER_API_KEY>
```
**Request Body**
```
{
  "title": "Update Title",
  "description": "Update Description",
  "event_time": "whenever",
  "event_location": "Aurora, CO"
}
```
**Response Body**
```
{
  "data": {
    "id": "6",
    "type": "event",
    "attributes": {
      "title": "Update Title",
      "description": "Update Description",
      "creator": "User 1",
      "event_time": "whenever",
      "event_location": "Aurora, CO",
      "invited": [],
      "accepted": [
        {
          "id": 1,
          "name": "User 1"
        }
      ],
      "declined": []
    }
  }
}
```

Invite A Friend To Event
------------------------
**Request**
```
POST https://lets-hang-be.herokuapp.com/api/v1/user/event/{EVENT_ID}
```
**Parameters**
```
api_key=<USER_API_KEY>
```
**Request Body**
```
{
  "friend_ids": [2,3]
}
```
**Response Body**
```
{
  "data": {
    "id": "7",
    "type": "event",
    "attributes": {
      "title": "Happy Hour",
      "description": "Meet after school at Brothers",
      "creator": "User 1",
      "event_time": "Around 4pm",
      "event_location": "Denver, CO",
      "invited": [
        {
          "id": 2,
          "name": "User 2"
        },
        {
          "id": 3,
          "name": "User 3"
        }
      ],
      "accepted": [
        {
          "id": 1,
          "name": "User 1"
        }
      ],
      "declined": []
    }
  }
}
```


User Can Decline Event Invite
-----------------------------

**Request:**
```
DELETE https://lets-hang-be.herokuapp.com/api/v1/user/event/{EVENT_ID}
```
**Parameters**
```
api_key=<USER_API_KEY>
```
**Response Body**
```
{
  "data": {
    "id": "7",
    "type": "event",
    "attributes": {
      "title": "Happy Hour",
      "description": "Meet after school at Brothers",
      "creator": "User 1",
      "event_time": "Around 4pm",
      "event_location": "Denver, CO",
      "invited": [
        {
          "id": 3,
          "name": "User 3"
        }
      ],
      "accepted": [
        {
          "id": 1,
          "name": "User 1"
        }
      ],
      "declined": [
        {
          "id": 2,
          "name": "User 2"
        }
      ]
    }
  }
}
```

User Can Accept Event Invite
----------------------------
**Request**
```
PATCH https://lets-hang-be.herokuapp.com/api/v1/user/event/{EVENT_ID}
```
**Parameters**
```
api_key=<USER_API_KEY>
```
**Response Body**
```
{
  "data": {
    "id": "7",
    "type": "event",
    "attributes": {
      "title": "Happy Hour",
      "description": "Meet after school at Brothers",
      "creator": "User 1",
      "event_time": "Around 4pm",
      "event_location": "Denver, CO",
      "invited": [],
      "accepted": [
        {
          "id": 1,
          "name": "User 1"
        },
        {
          "id": 3,
          "name": "User 3"
        }
      ],
      "declined": [
        {
          "id": 2,
          "name": "User 2"
        }
      ]
    }
  }
}
```

Friendship Endpoints
====================

Send Friend Request
-------------------
**Request**
```
POST https://lets-hang-be.herokuapp.com/api/v1/friendships
```
**Parameters**
```
api_key=<USER_API_KEY>
friend_id=<FRIEND_USER_ID>
```
**Response Body**
```
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

Accept Friend Request
---------------------
**Request**
```
PATCH https://lets-hang-be.herokuapp.com/api/v1/friendships/{REQUESTER_USER_ID}
```
**Parameters**
```
api_key=<USER_API_KEY>
```
**Response Body**
```
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

Decline Friend Request Or Remove Friend
---------------------------------------
**Request**
```
DELETE https://lets-hang-be.herokuapp.com/api/v1/friendships/{REQUESTER_USER_ID}
```
**Parameters**
```
api_key=<USER_API_KEY>
```
**Response Status**
```
status: 204
```

Local Installation
==================

Requirements
------------

* [Rails 5.2.3](https://rubyonrails.org/) - Rails Version
* [Ruby 2.4.1](https://www.ruby-lang.org/en/downloads/) - Ruby Version

Setup
-----

```
$ git clone git@github.com:lpile/lets-hang-be.git
$ cd lets-hang-be
$ bundle install
$ rails db:{create,migrate,seed}
```

Testing
-------

The full test suite can be run with `$ bundle exec rspec`.
