### **Things to follow when raising bugs in zWAN QA Project**

## **Bug Title:**

The issue title should be clear and contain the following 2 parts in it,

1. What is the issue or error?
2. When it is observed

Or

1. Where it is observed

###

E.g.,

- TWAMP Results are reporting undesired values when the CPEs times are different. (When)
- Firewall Rules in Custom Chain are not deleting while deleting the Custom chain. (When)
- Domain name and NIS domain fields are showing undefined in DHCP\MANAGE. (Where)

## **Bug Description**

**Describe the issue in detail with &#39;When it is occurring (conditions)&#39; and &#39;Where it is occurring&#39; with followings,**

## Steps to reproduce the issue:

Mention the steps to reproduce the issue so that developers can follow the steps to reproduce the issue at their end.

Include the test case ID which has test case steps.

Mention the actual result

## Error Logs/Screenshots:

Attach the error log/screenshots whenever possible.

## Expected Result:

Mention the expected result for the failed case.

## GraphQL Error/Mutation:

Include the GraphQL error/Mutation whenever possible.

## Test environment &amp; hardware:

Mention the test environment and hardware info such as Micro-Service tag version and CPE firmware version

## Isolation Points:

Whenever possible, mention the conditions/scenarios, the issue/error is not occurring.

## **Severity:**

**Set the severity based on**  **the undesirable effects it has on the zWAN portal in terms of its impact.**

_The examples are not comprehensive list,_

Few examples for Sev 1,

1. Implemented function is not starting/working as expected
2. Implemented function is breaks down
3. Implemented function is breaks down another functions
4. Implemented function is working in negative way

Few examples for Sev 2,

1. Implemented function is working partially
2. Implemented function is not working sporadically
3. Implemented function is not working after STOP/RESTART conditions

Few examples for Sev 3,

1. Implemented function is throwing error but working as expected

Few examples for Sev 4,

1. Bugs related to minor changes in the existing implementations, cosmetics, etc.,

## **Assignee:**

UI Related bugs - Vaghani Arjun

Backend issues – Srikumar S

| System / Setup (Sharon) | Network/Tunnels (Srikumar, Sharon and Senthil) |
| --- | --- |
| System/SSH (Jomy) | Network/QoS (Srikumar) |
| System/Logs (Srikumar) | Network/Net Balancer (Sharon) |
| System Monitoring (Srikumar) | Network/Router (Sharon/Venu) |
| Network/Interface (Jomy) | Network/Utilities (Jomy) |
| Network/Bridge (Sharon) | Security/Firewall (Srikumar) |
| Network/Bond (Jomy) | Security/X.509 (Sharon) |
| Network/DHCP (Jomy) |
##


## **Bug Watchers:**

Add the following persons into watchers list,

- Srikumar, Gowtham, Vaghani Arjun, Glenn, Sharon, Jomy, Venugopal, Senthilkumar, Anitha, Dhanesh, Somasundaram, Vinayagamoorthy, Dhinakaran, Ramesh and Sangeetha