# setup USB
import usb.core
dev = usb.core.find(idVendor=0x04e8, idProduct=0x6860) 
dev.reset()

# First time somehow doesnt work
try:
    dev.set_configuration(0x2)
except Exception:
    pass

# Second time it will
dev.reset()
dev.set_configuration(0x2)