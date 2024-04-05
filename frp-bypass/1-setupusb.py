import usb.core

VID = 0x04e8
PID = 0x6860
usbcfg = 0x2

print(f"Looking for Samsung device with VID {hex(VID)} and PID {hex(PID)}...")
while usb.core.find(idVendor=VID, idProduct=PID) is None:
    dev = usb.core.find(idVendor=VID, idProduct=PID)

counter: int = 1
while True:
    print(f"Attempt {counter}: Resetting USB device and setting configuration value...")
    
    dev.reset()
    try:
        dev.set_configuration(usbcfg)
        break
    except Exception:
        counter += 1
        pass

print(f"Please dial *#0*# in emergency dialer and proceed to script 2")