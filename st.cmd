#!../../bin/linux-x86_64/MKS946

#- You may have to change MKS946 to something else
#- everywhere it appears in this file

< envPaths

## Register all support components
dbLoadDatabase "../../dbd/iocxxxLinux.dbd"
iocxxxLinux_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "$(IP)/db")
epicsEnvSet ("PREFIX", "SSRL:A33600S:")
epicsEnvSet ("PORT", "serial1")

## Load record instances
drvAsynIPPortConfigure("serial1", "192.168.0.22:325", 0, 0, 0)
#asynOctetSetInputEos("serial1",0,"\r")
#asynOctetSetOutputEos("serial1",0,"\r")
asynSetTraceIOMask("serial1",0,ESCAPE)
asynSetTraceMask("serial1",0,DRIVER|ERROR)

dbLoadRecords("$(IP)/db/A33600S.db","P=$(PREFIX),PORT=serial1,M=m1,N=1")
dbLoadRecords("$(IP)/db/A33600S.db","P=$(PREFIX),PORT=serial1,M=m2,N=2")

dbLoadRecords("$(ASYN)/db/asynRecord.db", "P=$(PREFIX),R=asyn1,PORT=$(PORT),ADDR=0,IMAX=80,OMAX=80")

asynSetTraceIOMask("serial1",0,2)
asynSetTraceMask("serial1",0,9)


#cd "${TOP}/iocBoot/${IOC}"
iocInit

