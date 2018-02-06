# Link API

## API

* `POST /api/link/create/`
  
  * Request: 
    ```
    { 
        "long_url": "https://google.com/" 
    }
    ```
  * Response:
    ```
    {
        "id": 1,
        "long_url": "https://google.com/",
        "short_url_id": "lez"
    }
    ```

* `GET /api/link/list/`
  
  * Response:
    ```
    [
        {
            "id": 1,
            "long_url": "https://google.com/",
            "short_url_id": "lez"
        },
        {
            "id": 2,
            "long_url": "https://bing.com/",
            "short_url_id": "oli"
        }
    ]
    ```

* `GET /api/link/resolve/<short_url_id>/`
  
  * Request: `GET /api/link/resolve/lez`
  * Response:
    ```
    {
        "id": 1,
        "long_url": "https://google.com/",
        "short_url_id": "lez"
    }
    ```
