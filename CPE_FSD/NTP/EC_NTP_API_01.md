# Schema

https://gitlab.amzetta.com/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/system/modules/time/schema.gql

# GRAPHQL API

## Mutations

### Set System time

```
mutation{
  setTime(
    time:{
      year: \"2020\"
      month:\"03\"
      day:\"18\"
      hour:\"18\"
      minutes:\"18\"
      seconds:\"18\"
    }
  ){
    code
    message
    success
  }
}
```

### Set NTP

```
mutation{
  setNTP(
    ntp:{
      isNTPClient: true
      isNTPServer: true
      ntpServers: [\"0.pool.ntp.org\", \"1.pool.ntp.org\", \"2.pool.ntp.org\"]
    }
  ){
    code
    message
    success
  }
}
```

### Set Timezone

```
mutation{
  setTimeZone(timeZone:\"America/New_York\"){
    code
    message
    success
  }
}
```

### Sync to HWClock to UTC

```
mutation{
  setHWCTimescale(isUTC: true){
    code
    message
    success
  }
}
```

## Queries

### Query System Time

```
query{
	system{
    getTime{
      local
      utc
      hwclock
      isUTC
      timeZone
    }
  }
}
```

### Query NTP

```
query{
  system{
    ntp{
      ntpServers
      isNTPClient
      isNTPServer
    }
  }
}
```


### Query Timezones

```
query{
  system{
    timeZones
  }
}
```