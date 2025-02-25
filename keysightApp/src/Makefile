TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += keysightSupport

# Compile and add code to the support library
keysightSupport_SRCS += xxxRecord.c
keysightSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
keysightSupport_SRCS += dbSubExample.c
keysightSupport_SRCS += devkeysightVersion.c
keysightSupport_SRCS += keysightHello.c
keysightSupport_SRCS += initTrace.c

keysightSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = keysightVersion.h
# Macro name
GENVERSIONMACRO = keysightVERSION

# Build the IOC application
PROD_IOC = keysight

# keysight.dbd will be created and installed
DBD += keysight.dbd

# keysight.dbd will include these files:
keysight_DBD += base.dbd
keysight_DBD += xxxSupport.dbd
keysight_DBD += dbSubExample.dbd
keysight_DBD += devkeysightVersion.dbd
keysight_DBD += keysightHello.dbd
keysight_DBD += initTrace.dbd
keysight_DBD += asyn.dbd
keysight_DBD += drvAsynUSBTMC.dbd
keysight_DBD += drvAsynIPPort.dbd
keysight_DBD += drvAsynSerialPort.dbd
keysight_DBD += calc.dbd
keysight_DBD += stream-scalcout.dbd
keysight_DBD += stream.dbd
keysight_DBD += asSupport.dbd
# keysight_registerRecordDeviceDriver.cpp derives from keysight.dbd
keysight_SRCS += keysight_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
keysight_SRCS_DEFAULT += keysightMain.cpp
keysight_SRCS_vxWorks += -nil-

# Link in the code from our support library
keysight_LIBS += keysightSupport
keysight_LIBS += asyn
keysight_LIBS += calc
keysight_LIBS += autosave
keysight_LIBS += stream
# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into keysightSupport
    sncExample_SNCFLAGS += +r
    keysight_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    keysightSupport_SRCS += sncExample.stt
    keysightSupport_LIBS += seq pv
    keysight_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    keysight_LIBS += qsrv
    keysight_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    keysight_DBD += PVAServerRegister.dbd
    keysight_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
keysight_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devkeysightVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
