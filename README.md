# Check service startup

## About

---

This script allows to check the HTTP response of the service after startup. Can be used for example in Jenkins job to check if the service in web application server started successfully.

## Usage

---

Run the scirpt with parameters:
* time [s] in which the script is to be executed
* URL address of the service

Example:
```aidl
./checkServiceStartup.sh 20 https://www.google.com/
```