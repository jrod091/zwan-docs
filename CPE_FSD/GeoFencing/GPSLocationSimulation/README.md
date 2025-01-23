## GPS Location Simulation:

    To simulate GPS location on any EC/vCPE follow the steps:
    
    Clone/Copy the folder GPSLocationSimulation to the EC/vCPE.
    Goto GPSLocationSimulation folder.

    1. Copy the LocationInfo to /var/register/
        
        cp LocationInfo /var/register/

    2. Copy the get_gps_location.sh file to /root/zwan-cpe/common/schliersee/scripts/amz/
        
        cp get_gps_location.sh file /root/zwan-cpe/common/schliersee/scripts/amz/
        chmod +x /root/zwan-cpe/common/schliersee/scripts/amz/get_gps_location.sh

    3. If it is vCPE or any X86 without LTE interface,  copy the WWAN00 folder to /var/register/system/net/interfaces/

        cp -rf WWAN00 /var/register/system/net/interfaces/

    4. Touch the file in /var/register
        
        touch /var/register/GPSLocationSimulation
