import usb.core

VID = 0x04e8
PID = 0x6860
usbcfg = 0x2

# TODO: look for USB device
#while (true):
    #poll for device
    #break

dev = usb.core.find(idVendor=VID, idProduct=PID)

counter: Int = 1
while True:
    print(f"Attempt {counter}: Resetting USB device and setting configuration value...")
    
    dev.reset()
    try:
        dev.set_configuration(usbcfg)
        break
    except Exception:
        counter += 1
        pass
