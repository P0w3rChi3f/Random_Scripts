# Sysmon  

My Personal Sysmon Config.  The executables are from [Mark Russinovich's Sysinternals](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon).  The original sysmon config came from [SwiftOnSecurity's GitHub Page](https://github.com/SwiftOnSecurity/sysmon-config).  

The following notes are from SwiftSecurity

___

## Usage

### Install  

Run with adminstrator rights

```cmd
sysmon.exe -accepteula -i sysmonconfig-export.xml
```  

### Update existing config

Run with administrator rights

```cmd
sysmon.exe -c sysmonconfig-export.xml
```  

### Uninstall  

Run with administrator rights

```cmd
sysmon.exe -u
```  

___  

## Required actions  

### Prerequisites  

Highly recommend using [Notepad++](https://notepad-plus-plus.org/) to edit this configuration. It understands UNIX newline format and does XML syntax highlighting, which makes this very understandable. I do not recommend using the built-in Notepad.exe.

### Customization  

You will need to install and observe the results of the configuration in your own environment before deploying it widely. For example, you will need to exclude actions of your antivirus, which will otherwise likely fill up your logs with useless information.

The configuration is highly commented and designed to be self-explanatory to assist you in this customization to your environment.

### Design notes  

This configuration expects software to be installed system-wide and ***NOT*** in the ***C:\Users*** folder.

If your users install Chrome themselves, you should deploy the [Chrome MSI](https://cloud.google.com/chrome-enterprise/browser/download/), which will automatically change the shortcuts to the machine-level installation. Your users will not even notice anything different.  

___

## Intigration into Elastic  

### Download the Shipper (Winlogbeat)  

Download the version of [Winlogbeat](https://www.elastic.co/downloads/beats/winlogbeat) that matches your version of Logstash.  You can find your version by following the instructions below.  

1. Click `Management` on the left hand side.  Then you will see the `Kibana` version ins the middle of the screen.  This corrisponds to your version of Logstash and the Winlogbeat you need to down load.  

![Kibana Version](https://drive.google.com/file/d/1hxnUmrOkoYg6wd5N4s3O1ATw6Sgy-lxi)  

Once winlogbeat has been downloaded you can follow the [instructions on Elastic](https://www.elastic.co/guide/en/beats/winlogbeat/6.8/winlogbeat-getting-started.html) to finish ***Your*** install.  
