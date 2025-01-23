## QoS OVERVIEW
<p>Zwan Traffic Shaping for each interface is achieved using QoS classes. The interface could be Ethernet, VPN, Bond or Bridge.</p>

### Funtionality
<p>QoS Class has one ore more Flow Classification Rules and the Shaping parameters called Policy which includes bandwidth limit and priority. One or more such QoS Classes are applied to an interface. When packet flows through the interface, it will go through each QoS Class one by one and its rule one by one until the packet matches with a rule. If the packet match the filer specified in the rule, then it will honor the Bandwidth limit set which was contained by the QoS Class.</p>
To put it simple:<br>
1. Create one or more flow classification rule<br>
1. Create QoS Class with bandwidth control (like maximum bandwidth and guaranteed bandwidth) and priority<br>
1. Associate the Flow Classification rule to the QoS Class.<br>
1. Then add the one of more QoS class to an interface.<br>
1. QoS Class within an interface can be enabled or disabled. Make sure appropriate QoS Class is enabled for that Interface.<br>
1. Qos for an Interface can be enabled or disabled. Make sure it is enabled.<br>
1. Make sure all the changes are saved<br>

### QoS Policies:
1. Priority (high or low) - high priority Class gets more priority while traffic shaping<br>
1. Guaranteed minimum bandwidth - Specify minimum bandwidth guaranteed for a QoS Class<br>
1. Maximum Bandwidth - Specify minimum bandwidth guaranteed for a QoS Class<br>
1. DSCP marking - Optionally set DSCP marking. Packets that uses this QoS Class, will have DSCP mark specified here<br>

### QoS Rule:
Refer Flow Classification section for Rules. Set one of the QoS class manager as Target for the rule<br>

## PREREQUISITE FOR QoS
1. LAN PCs connected to the Edge controller and internet should work fine for the LAN PCs<br>
1. In case of Tunnels with QoS, Corresponding tunnel configuration should be done before executing the QoS policies.<br>

## QoS CONFIGURATION VIA ONDEMAND POLICY
**List of Templates**
1. qosClass.yml -  'QoS Create Class'<br>
1. qosClassRule.yml - "QoS Create Classifier"<br>
1. qosInterfaceBandwidth.yml - 'QoS Set interface bandwidth'<br>
1. qosInterfaceClassBandwidth.yml - 'QoS Set interface class bandwidth'<br>
1. qosClassRuleInterface.yml - "QoS Compound Template to create Class and Application aware Classifier"<br>

Step1: On-board the required edge controllers to the provider UI<br>
Step2: Navigate to Edge controller list --> Configurations --> Metadata --> Create/Import metadata for the Edge devices.<br>

**Metadata details**
![QA](images/Metadata_for_QoS.png)<br>
![QA](images/Metadata_for_QoS_1.png)<br>
![QA](images/Metadata_for_QoS_2.png)<br>
![QA](images/Metadata_for_QoS_3.png)<br>
![QA](images/Metadata_for_QoS_4.png)<br>

### QoS CLASS TEMPLATE - CREATE CLASS
**Action for QoS Class**<br>
Step3: Navigate to Edge controller list --> Configurations --> Actions --> Templates page<br>
![QA](images/Import_template.png)<br>

Step4: Go to Actions tab --> click on create action --> select the QoS create class template --> now create the action for QoS Class<br>
![QA](images/Create_Action_QoS_Class.png)<br>
![QA](images/Create_Action_QoS_Class_1.png)<br>

Step5: Navigate to Policy --> Create Policy for QoS Class with the Action that is created in previous steps.<br>
![QA](images/Create_Policy_QoS_Class.png)<br>

Step6: Click on apply policy in order to apply to the specific device or group of device as below<br>

Step7: Navigate to Configuration --> Jobs --> On demand --> Node policy --> Click on the details of the job on the right corner and verify the policy results.<br>
![QA](images/Job_Detail_QoS_Class.png)<br>

### RESULTS FOR QoS CLASS
Step8: After Applying policy --> Navigate to the edge controller and verify the updated changes in QoS that is done via policy<br>
![QA](images/After_Applying_Policy_QoS_Class.png)<br>

### QoS CLASS RULE TEMPLATE - QoS CREATE CLASSIFIER
**Action for QoS Class**<br>
Step1: Navigate to Edge controller list --> Configurations --> Actions --> Templates page and import the QoS class rule template<br>
![QA](images/Import_template.png)<br>

Step2: Navigate to Configurations --> Actions --> Actions page<br>
![QA](images/Create_Action_Dialog.png)<br>

Step3: Go to Actions tab --> click on create action --> select the QoS Create Classifier Template --> now create the action for QoS Classifier rule<br>
![QA](images/Create_Action_QoS_Classifier.png)<br>
![QA](images/Create_Action_QoS_Classifier_1.png)<br>
![QA](images/Create_Action_QoS_Classifier_2.png)<br>
![QA](images/Create_Action_QoS_Classifier_3.png)<br>

Step4: Navigate to Policy --> Create Policy for QoS Classifer rule with the Action that is created in previous steps and apply it to the specific device or group of device as below<br>
![QA](images/Apply_Policy_QoS_Classifier.png)<br>

Step5: Navigate to Configuration --> Jobs --> On demand --> Node policy --> Click on the details of the job on the right corner and verify the policy results.<br>
![QA](images/Job_Detail_QoS_Classifier.png)<br>

### RESULTS FOR QoS CLASSIFIER
Step6: After Applying policy --> Navigate to the edge controller and verify the updated changes in QoS classifier page that is done via policy<br>
![QA](images/After_Applying_Policy_QoS_Classifier.png)<br>

### QoS INTERFACE BANDWIDTH - QoS SET INTERFACE BANDWIDTH
**Action for QoS Interface Bandwidth**<br>
Step1: Navigate to Edge controller list --> Configurations --> Actions --> Templates page and import the QoS set interface bandwidth template<br>

Step2: Navigate to Configurations --> Actions --> click on create action --> select the QoS set interface bandwidth template --> now create the action for QoS set interface bandwidth template rule<br>
![QA](images/Create_Action_QoS_Interface_Bandwidth.png)<br>

Step3: Navigate to Policy --> Create Policy for QoS set interface bandwidth with the Action that is created in previous steps and apply it to the specific device or group of device as below<br>

Step4: Navigate to Configuration --> Jobs --> On demand --> Node policy --> Click on the details of the job on the right corner and verify the policy results.<br>

### RESULTS FOR QoS SET INTERFACE BANDWIDTH
Step5: After Applying policy --> Navigate to the edge controller and verify the updated changes in QoS interface manager page that is done via policy<br>
![QA](images/After_Applying_Policy_QoS_Set_Interface_Manager.png)<br>

### CONCLUSION FOR QoS CLASS, CLASSIFIER AND SET INTERFACE BANDWIDTH TEMPLATES
QoS class, QoS classifier and Set interface bandwidth are inter connected to each other. After applying all three templates verify the QoS functionality in the LAN PCs<br>
Login to the LAN PC and do a FTP file transfer via the Tunnels. By doing this corresponding DSCP values will be applied and verify the DSCP marking in VPN interfaces using tcpdump <br>
![QA](images/Verify_QoS.png)<br>
![QA](images/Tcpdump_for_QoS_In_VPN.png)<br>

### QoS COMPOUND TEMPLATE - CREATE CLASS, CLASSIFIER, INTERFACE MANAGER IN A SINGLE TEMPLATE
**Action for QoS Compound template**<br>
Step1: Navigate to Edge controller list --> Configurations --> Actions --> Templates page and import the QoS compound template to create class and application aware classifier rule template<br>
![QA](images/Import_template.png)<br>

Step2: Navigate to Configurations --> Actions --> click on create action --> select the QoS Compound template to create a class and application aware classifier rule --> now create the action for QoS Classifier rule<br>
![QA](images/Create_Action_QoS_Compound_Template.png)<br>
![QA](images/Create_Action_QoS_Compound_Template_1.png)<br>
![QA](images/Create_Action_QoS_Compound_Template_2.png)<br>

Step3: Navigate to Policy --> Create Policy for QoS Compound tempalate with the Action that is created in previous steps and apply it to the specific device or group of device as below<br>
![QA](images/Apply_Policy_QoS_Compound_Template.png)<br>

Step4: Navigate to Configuration --> Jobs --> On demand --> Node policy --> Click on the details of the job on the right corner and verify the policy results.<br>
![QA](images/Job_Detail_QoS_Compound_Template.png)<br>

### CONCLUSION FOR QoS COMPOUND TEMPLATE
Step6: After Applying policy --> Navigate to the edge controller and verify the updated changes in QoS Interface manager page, Class manager page and Classifier page that is done via policy<br>
![QA](images/After_Applying_Policy_QoS_Compound_Template_Interface_Manager.png)<br>
![QA](images/After_Applying_Policy_QoS_Compound_Template_Class.png)<br>
![QA](images/After_Applying_Policy_QoS_Compound_Template_Classifier.png)<br>

Step7: Now verify the Google cloud websites from the LAN PCs since we added the classifier rule for google cloud in QoS
![QA](images/After_Applying_Policy_QoS_Compound_Template_LAN_PC.png)<br>
