import usb.core

# set ur values here
VID=0x04e8
PID=0x6860
usbcfg = 0x2

# look for USB device
dev = usb.core.find(idVendor=VID, idProduct=PID)

# first time will always fail. (i have no idea why)
print("[1/2] Resetting USB device and setting configuration value...")
dev.reset()
try:
    dev.set_configuration(usbcfg)
except Exception:
    print("  !! Task failed successfully.\n  :: This should be completely normal, dont ask me why...")
    pass

# second time's the charm.
print("[2/2] Trying again... (No output if it succeeds)")
dev.reset()
try:
    dev.set_configuration(usbcfg)
except Exception:
    print("  !! Failed to set configuration...\n  :: Value is already set or it actually failed...\n")
