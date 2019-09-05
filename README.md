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
