#!../../bin/linux-x86_64/MKS946

#- You may have to change MKS946 to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/MKS946.dbd"
MKS946_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/MKS946App/Db")
epicsEnvSet ("PREFIX", "SLAC:MKS946:")
epicsEnvSet ("PORT", "serial1")

## Load record instances
drvAsynSerialPortConfigure("serial1", "/dev/ttyUSB", 0, 0, 0)
asynOctetSetInputEos("serial1",0,"FF")
asynOctetSetOutputEos("serial1",0,"FF")
asynSetOption("serial1",0,"baud","115200")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"clocal","Y")
asynSetOption("serial1",0,"crtscts","N")

dbLoadRecords("$(IP)/db/MKS946MFC.db","P=$(PREFIX),PORT=serial1,MFC=mfc1,N=1")
dbLoadRecords("$(IP)/db/MKS946MFC.db","P=$(PREFIX),PORT=serial1,MFC=mfc2,N=2")


asynSetTraceIOMask("serial1",0,2)
asynSetTraceMask("serial1",0,9)


cd "${TOP}/iocBoot/${IOC}"
iocInit
