# WAN overall download bandwidth alert


Montior a specific WAN interface across all the CPE managed in the director for their download bandwidth. Based on the trigger threshold generate a Alert .

Three main components for configuring Alert:
- Extraction query ( in monitor )
- Trigger condition (in trigger)
- Message (in action)


## Configuring the extraction query in Monitor

- To monitor a particular WAN interface change the flow.output_ifname value to required WAN interface (21 line in the extraction query) 

        "prefix": {
             "flow.output_ifname": {
                 "value": "<ENTER THE REQUIRED WAN INTERFACE>",
                 "boost": 1
              }
        }

    example:

                   "prefix": {
                        "flow.output_ifname": {
                            "value": "WAN00",
                            "boost": 1
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
                        "prefix": {
                            "flow.output_ifname": {
                                "value": "WAN00",
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
                            "bytes": "desc"
                        },
                        {
                            "_key": "desc"
                        }
                    ]
                },
                "aggregations": {
                    "bytes": {
                        "sum": {
                            "field": "flow.bytes"
                        }
                    },
                    "interface": {
                        "terms": {
                            "field": "flow.output_ifname",
                            "size": 10,
                            "min_doc_count": 1,
                            "shard_min_doc_count": 0,
                            "show_term_doc_count_error": false,
                            "order": [
                                {
                                    "bytes": "desc"
                                },
                                {
                                    "_key": "desc"
                                }
                            ]
                        },
                        "aggregations": {
                            "bytes": {
                                "sum": {
                                    "field": "flow.bytes"
                                }
                            }
                        }
                    }
                }
            }
        }
    }

## Configuring the Trigger condition in trigger

- In the trigger condition user need to specify the download bandwidth threshold limit in the Mbps.(in the example the 10 is denoted internally as 10Mbps)
- Enter the trigger condition while configuring the trigger for Alert.

         ctx.results[0].hits.total.value > 0 && (((ctx.results[0].aggregations.hostname.buckets[0].interface.buckets[0].bytes.value/ 1048576)*8)/60) > <user defined bandwidth threshold Mbps>

example:

    ctx.results[0].hits.total.value > 0 && (((ctx.results[0].aggregations.hostname.buckets[0].interface.buckets[0].bytes.value/ 1048576)*8)/60) > 10

## Configuring message in action

Enter the message template in the message while configuring the actions

    Monitor {{ctx.monitor.name}} just entered alert status. Please investigate the issue.
    There may be multiple alerts generated during the time frame but they were generated from the edge-controllers/CPEs listed below:-


    ** List of alerts:-

    {{#ctx.results.0.aggregations.hostname.buckets}}

    ---[ CPE Details ]--------------------------------------------------------------------------

    - Hostname: {{key}}
    {{#interface.buckets}}
        - WAN interface: {{key}}
        - Data value: {{bytes.value}} bytes
    {{/interface.buckets}}
    {{/ctx.results.0.aggregations.hostname.buckets}}

