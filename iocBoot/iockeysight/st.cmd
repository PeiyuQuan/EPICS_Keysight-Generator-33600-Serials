#!../../bin/linux-x86_64/y

#- You may have to change y to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "${TOP}/dbd/keysight.dbd"
keysight_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/keysightApp/Db")
epicsEnvSet ("PREFIX", "SSRL:A33600S:")
epicsEnvSet ("PORT", "usbtmc1")

## Load record instances
drvAsynIPPortConfigure("usbtmc1","192.168.0.22:5025",0,0,0)
#usbtmcConfigure("usbtmc1", "0x0957", "0x4b07", "MY59002341",0,0)
asynOctetSetInputEos("usbtmc1",0,"\n")
asynOctetSetOutputEos("usbtmc1",0,"\n")


dbLoadRecords("${TOP}/keysightApp/Db/A33600S.db","P=$(PREFIX),PORT=usbtmc1,M=m1,N=1")
dbLoadRecords("${TOP}/keysightApp/Db/A33600S.db","P=$(PREFIX),PORT=usbtmc1,M=m2,N=2")

dbLoadRecords("$(ASYN)/db/asynRecord.db", "P=$(PREFIX),R=asyn1,PORT=usbtmc1,ADDR=0,IMAX=80,OMAX=80")


cd "${TOP}/iocBoot/${IOC}"
iocInit


