# Application overall bandwidth alert


Montior a specific Application across all the  CPE managed in the director . Based on the trigger threshold, alerts are generated.

Three main components for configuring Alert:
- Extraction query ( in monitor )
- Trigger condition (in trigger)
- Message (in action)


## Configuring the extraction query in Monitor

- To monitor a particular application change the flow.app_noproto value to required WAN interface (21 line in the extraction query) - get the application name from App/Domain view dashboard.

                {
                    "term": {
                        "flow.app_noproto": {
                            "value": "<Enter the Application name as in 'App/Domain view'>",
                            "boost": 1
                        }
                    }
                }

    example:

                {
                    "term": {
                        "flow.app_noproto": {
                            "value": "youtube",
                            "boost": 1
                        }
                    }
                }


### Extraction query

    {
        "size": 0,
        "query": {
            "bool": {
                "filter": [
                    {
                        "range": {
                            "@timestamp": {
                                "from": "{{period_end}}||-5m",
                                "to": "{{period_end}}",
                                "include_lower": true,
                                "include_upper": true,
                                "format": "epoch_millis",
                                "boost": 1
                            }
                        }
                    },
                    {
                        "term": {
                            "flow.app_noproto": {
                                "value": "youtube",
                                "boost": 1
                            }
                        }
                    }
                ],
                "adjust_pure_negative": true,
                "boost": 1
            }
        },
        "aggregations": {
            "hostname": {
                "terms": {
                    "field": "node.hostname",
                    "size": 100,
                    "min_doc_count": 1,
                    "shard_min_doc_count": 0,
                    "show_term_doc_count_error": false,
                    "order": [
                        {
                            "byte": "desc"
                        },
                        {
                            "_key": "asc"
                        }
                    ]
                },
                "aggregations": {
                    "byte": {
                        "sum": {
                            "field": "flow.bytes"
                        }
                    }
                }
            }
        }
    }

## Configuring the Trigger condition in trigger

- In the trigger condition user need to specify the Application bandwidth threshold limit in the Mbps.(in the example the 10 is denoted internally as 10Mbps)
- Enter the trigger condition while configuring the trigger for Alert.

         ctx.results[0].hits.total.value > 0 && (((ctx.results[0].aggregations.hostname.buckets[0].byte.value/ 1048576)*8)/60) > <user defined bandwidth threshold Mbps>

example:

    ctx.results[0].hits.total.value > 0 && (((ctx.results[0].aggregations.hostname.buckets[0].byte.value/ 1048576)*8)/60) > 10
    

## Configuring message in action

- Enter the message template in the message while configuring the actions. 
- Enter the correct application and thershold bandwidth in the message.

        Monitor {{ctx.monitor.name}} just entered alert status. Please investigate the issue.
        
        youtube  application usage bandwidth limit cross 10mbps
        ** List of alerts:-

        {{#ctx.results.0.aggregations.hostname.buckets}}

        ---[ CPE Details ]--------------------------------------------------------------------------

        - Hostname: {{key}}
        - Data value: {{byte.value}} bytes
        {{/ctx.results.0.aggregations.hostname.buckets}}
