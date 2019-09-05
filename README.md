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
POST /api/v1/user/edit
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
