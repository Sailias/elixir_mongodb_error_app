# MongoErrorTest

## Setup

config.exs: 

```
config :mongo_error_test, 
  database: "your_database_name"
```

## Run

```
$ iex -S mix
> MongoErrorTest.Tester.run()
```

## App side fix

Worker.ex:12

```
# Uncomment below to wait for mongo conn to become available
# Process.sleep(100)
```