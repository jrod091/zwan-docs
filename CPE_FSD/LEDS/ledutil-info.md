<p class="has-line-data" data-line-start="0" data-line-end="1">LEDUTIL</p>
<p class="has-line-data" data-line-start="2" data-line-end="5">Ledutil is an executable to control leds based on config file.<br>
The config file has to be placed in /etc/ folder with &lt;model_name&gt;_led.config.<br>
The model name is obtained from /sys/firmware/devicetree/base/model file.</p>
<p class="has-line-data" data-line-start="6" data-line-end="9">Config:<br>
The config file will have the below contents.<br>
#define &lt;system_state&gt; “action[on/off/blink] ledname(,s) pattern [on-period:off-period:duration] (ms) offledname(,s)”</p>
<p class="has-line-data" data-line-start="10" data-line-end="12">Example:<br>
#define BOOT_PROCESS “blink cpeblue,cpegreen 1000:1000:-1 cpered”</p>
<p class="has-line-data" data-line-start="13" data-line-end="15">Network interface:<br>
#define &lt;interface alias&gt;_action[up/down] “action[on/off/blink] ledname(,s) pattern [on-period:off-period:duration] (ms) offledname(,s)”</p>
<p class="has-line-data" data-line-start="16" data-line-end="19">Example:<br>
#define LTE0_DOWN “blink lte1 500:500:-1”<br>
#define LTE0_SIM_MISSING “off lte1”</p>
<p class="has-line-data" data-line-start="20" data-line-end="30">Usage:<br>
ledutil state<br>
To run on foreground during blink:<br>
ledutil &lt;state&gt; -f<br>
Self test<br>
ledutil selftest<br>
Debug<br>
ledutil &lt;state&gt; -d<br>
Network interface<br>
ledutil IFC_&lt;interface name&gt;_action</p>
<p class="has-line-data" data-line-start="31" data-line-end="35">Example:<br>
/usr/bin/ledutil BOOT_PROCESS<br>
/usr/bin/ledutil RECOVERY_BOOT -f<br>
/usr/bin/ledutil IFC_ETH00_UP</p>
<p class="has-line-data" data-line-start="36" data-line-end="37">Note: ledutil blink would terminate running instances of ledutil blink running on the same leds. blink action would run as daemonized background process.</p>
<p class="has-line-data" data-line-start="38" data-line-end="39">amz7622 board config file:
<a href="https://gitlab.amzetta.com/sdwan/zwan-arm/-/blob/1.2_QABUGFIX/rootfs/amz7622/amz7622_led.config">https://gitlab.amzetta.com/sdwan/zwan-arm/-/blob/1.2_QABUGFIX/rootfs/amz7622/amz7622_led.config</a></p>