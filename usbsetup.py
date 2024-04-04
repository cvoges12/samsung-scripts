import usb.core
dev = usb.core.find(idVendor=0x04e8, idProduct=0x6860) 
dev.reset()
dev.set_configuration(0x2) 
