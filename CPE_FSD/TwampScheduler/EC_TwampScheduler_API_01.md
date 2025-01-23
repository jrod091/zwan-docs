**Schema**

https://172.16.120.65/sdwan/zwan-cpe/blob/release-0.1.0-diab/common/tegernsee/src/gql/network/modules/utilities/schema.gql

**GRAPHQL API**

**Mutations**

*Add Global Schedule*

    mutation{
        addGlobalTwampSchedule(schedule: {isGlobal:true,
 			minute:\"*/1\",
 			hour:\"*\",
 			dayofmonth:\"*\",
 			month:\"*\",
 			dayofweek:\"*\",
 			status:true,
 			timezone:\"America/New_York\"		
 			override:true}) {
            code,
            message,
            success
        }
    }

*Remove Global Schedule*

        mutation{
            removeTwampGlobalSchedule {
                code,
                message,
                success
                }
            }

*Add Session Schedule*

        mutation{
            addTwampSessionSchedule(scheduleArray:
    		    [ sessionconfig: {  mode:sender},
                    schedule: {
                        sessionid:\"7222cb930904345cd8abc720fc63975f\"
                        isGlobal:false,
                        minute:\"*/2\",
                        hour:\"*\",
                        dayofmonth:\"*\",
                        month:\"*\",
                        dayofweek:\"*\",
                        status:true,
                        timezone:\"America/New_York\"
                        override:true
                    } }]) {
                    code,
                    message,
                    success
                }
            }

*Remove session Schedule*

        mutation{
            removeTwampSessionSchedule(
                sessionid:      [\"7222cb930904345cd8abc720fc63975f\"]) {
                code,
                message,
                success
                }
            }

*Start Global Schedule*
    
    mutation{
        startTwampGlobalSchedule{
            code,
            message,
            success
        }
    }

*Stop Global and All Session Schedule*

        mutation {
            stopTwampSchedule(stop_all:true, is_global:true) {
                code,
                message,
                success
                
            }
        }

*Start all Session Schedule*
        mutation {
            startTwampSessionSchedule(start_all:true) {
                code,
                message,
                success
                
            }
        }

**Queries**

*List Twamp Schedule Info*

        query{
        network{
            listTwampScheduleInfo{
            sessionid
            minute
            hour
            dayofmonth
            month
            dayofweek
            timezone
            status
            currentStatus
            isGlobal
            override
            taskid
            
            }
        }
    }
*List available timezones*

        query {
            network {
                listTimeZones
            }
        }