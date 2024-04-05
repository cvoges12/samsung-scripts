import usb.core

usbcfg = 0x2

def find_usb():
    VID: int = 0x04e8
    PID: int = 0x6860
    print(f"Looking for Samsung device with VID {hex(VID)} and PID {hex(PID)}...")

    return usb.core.find(idVendor=VID, idProduct=PID)

dev = find_usb()
while dev is None:
    dev = find_usb()

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