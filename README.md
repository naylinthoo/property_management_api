# README

`Ruby Version - 3.3`
`Node Version - v20.19.5`

Before setting up this project, please make sure you already installed ruby and nodejs in your device.


## How to run

### Backend

```
bundle install
```

```
rails s
```

### Nodejs Backend

```
yarn install
```

```
node server.js
```


### Frontend

Please install yarn using node before this setup.

```
yarn install
```

```
yarn dev
```


## Why I chose this architecture

I did some research before starting this project and I found that for the property management project which has a lot of CRUD heavy operations, a mature Framework is better to use.

And when I found that `Airbnb` uses `Ruby on Rails` as the primary Backend and `Nodejs` as the helper microservice functions, thats what I decided to do.

And for frontend, I used `React - Nextjs` for modular components and a better overall framework.

## How I would scale

To be honest, even if we were to scale this to 1000+ preperties, current infrastructure would be fine but for the sake of future proofing, I would use microservices to split up some tasks.

For example, if we are going to use (Operto, Hostaway) API webhooks, `Ruby on Rails` can handle webhooks normally but it would handle them in queues and background jobs. If 500 webhooks were to come at once, the maximum thread we can setup is 16 - 32 threads, which mean we can process maximum 32 webhooks at once, but others would have to wait in a line. This is not a problem but using 32 threads uses memory a lot and will cost more for the server fees. 

So I will use `Nodejs` miscroservices, think of it as a smaller plugin project, just to handle those 500 webhooks. `Nodejs` uses a non-blocking I/O which means it can process all 500 webhooks at once without using multiple threads (it can only use 1 thread). And then call `Rails API` at a controlled rate (throttling, batching, or just sequentially) and even retry failed webhooks.

And Webhooks have certain timeouts. Which will become a problem if they were to wait in a line for so long ( will explain more in the interview ).

## How I would improve

- Searching is done in Frontend, which is fine for now but when theres too many data, Backend should handle it.
- I used `Notion` integration without the `background process`, I will use background process for it.
- I would write unit tests to auto run when CI/CD (deploy). For now it only checks basic stuff before deploying.
- I would use decorator for the Backend (not needed because theres not much columns in the tables for now)
- I would use user authentication (its not defined in the document), so for now I use a secret key to communicate between Frontend and Backend.
- I'd use a theme system like MUI for the Frontend Nextjs.

