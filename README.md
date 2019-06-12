## Intricaly API Challange documentation

The objective of this challenge is to evaluate your knowledge of Ruby on Rails, Git, Design Patterns, Testing, APIs, Database Design and SQL.The API store DNS records (IP addresses) belonging to hostnames.

#### Commands

You can run the application with the

```bash
rails s
```
And You can test the application with the

```bash
rspec
```

#### Base URL

The base URL of the API is `/api/v1/`. Feel free to test the API using [Postman](https://www.getpostman.com/) or in the console directly.

#### Post a DNS with hostnames `POST 'dns'`

Will post a new dns with hostnames on our API's database
In the request body, you have to send the details of the dns and hostnames, in the following JSON format:

```bash
curl -H "Content-Type: application/json" -X POST -d '{"IP":"1.1.1.1", "hostnames": ["lorem.com","ipsum.com","dolor.com","amet.com"] }' http://localhost:3000/api/v1/dns
```

The API will respond with the id of the created DNS (in JSON format), e.g:

```json
{
  "id": 8
}
```

#### Get DNS with hostnames `GET 'dns'`

Will get you the JSON file of all dns. E.g:

```bash
curl -g  http://localhost:3000/api/v1/dns\?page\=1\&included\[\]\=ipsum.com\&included\[\]\=dolor.com\&excluded\[\]\=sit.com
```

```json
{
    "total": 2,
    "dns": [
        {
            "id": 1,
            "IP": "1.1.1.1"
        },
        {
            "id": 3,
            "IP": "3.3.3.3"
        }
    ],
    "hostnames": [
        {
            "name": "lorem.com",
            "match": 1
        },
        {
            "name": "amet.com",
            "match": 2
        }
    ]
}
```


