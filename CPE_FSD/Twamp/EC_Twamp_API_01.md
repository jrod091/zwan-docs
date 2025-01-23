**Schema**

https://172.16.120.65/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/utilities/schema.gql

**GRAPHQL API**

**Mutations**

*Add and Run Twamp Session*
mutation {

    runTwamp(sessionconfig: [{
            mode: sender,
            remoteIP: \"40.40.40.3\",
            remotePort: 15000,
            localIP: \"40.40.40.2\",
            localPort: 15001,
            count: 100,
            interval: 100,
            runMode: \"sync\",
            globalSchedule:true
        },
        {
            mode: sender,
            remoteIP: \"30.30.30.3\",
            remotePort: 16000,
            localIP: \"30.30.30.2\",
            localPort: 16001,
            count: 100,
            interval: 100,
            runMode: \"sync\"
        }
    ])
    {
        code,
        message,
        success,
        output {
            config {
                remoteIP
                remotePort
                localIP
                localPort
                count
                interval
                mode
                sessionid
            },
            result {
                sessionid
                inbound {
                    minLatency
                    maxLatency
                    averageLatency
                    jitter
                    packetLoss
                    timeStamp
                }
                outbound {
                    minLatency
                    maxLatency
                    averageLatency
                    jitter
                    packetLoss
                }
                roundtrip {
                    minLatency
                    maxLatency
                    averageLatency
                    jitter
                    packetLoss
                }
            }
        }
    } }

*Add Twamp Responder Session*

    mutation {
      runTwamp(sessionconfig:[
        { mode:responder,
          localIP:\"40.40.40.3\", 
          localPort:15000,
          runMode:\"async\"},
        { mode:responder,
          localIP:\"30.30.30.3\",
          localPort:16000,
          runMode:\"async\"}]) {
        code
        message
        success
      }
    }

*Delete Twamp Session*

    mutation{
      deleteTwampSession(sessionIDArray:[\"9f2e8422950c97bed324b8aa20074070\"]) {
        code
        message
        success
      }
    }

*Delete Twamp Responder Session*

    mutation{
      deleteTwampSession(sessionIDArray:[\"4edf522950c97bed324b8aa20074070\"]) {
        code
        message
        success
      }
    }

**Queries**

    query {
      network {
        getTwampResults {
          config {
            sessionid
            tunnelName
            localIP
            remoteIP
            localPort
            remotePort
            mode
            ttl
            
            dscp
            paddingBytes
            timerValue
            count
            interval
            sessionTime
          }
          result {
            sessionid
            inbound {
              averageLatency
              minLatency
              maxLatency
              jitter
              packetLoss
              timeStamp
              }
            outbound{
              averageLatency
              minLatency
              maxLatency
              jitter
              packetLoss
              timeStamp
              }
            roundtrip {
              averageLatency
              minLatency
              maxLatency
              jitter
              packetLoss
              timeStamp
              }
          }
        }
      }
    }
