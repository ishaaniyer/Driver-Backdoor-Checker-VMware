#include <ntddk.h>

extern unsigned int VmwareBackdoorCheck(void);

BOOLEAN IsRunningInVmware()
{
    unsigned int result = 0;

    __try {
        result = VmwareBackdoorCheck();
    }
    __except (EXCEPTION_EXECUTE_HANDLER) {
        result = 0;
    }

    return (result != 0);
}

VOID DriverEntry()
{
    DbgPrint("Running in VMware? %s\n", IsRunningInVmware() ? "Yes" : "No");
}
