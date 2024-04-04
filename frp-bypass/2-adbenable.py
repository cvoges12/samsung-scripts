import serial
import time

# set serial port + baud rate
port="/dev/ttyACM0"
baudrate=115200
ser = serial.Serial(port, baudrate=baudrate)

print("Using port", port, "set to", baudrate, "baud...")

# r/w function
def write_and_read(ser, command):
    try:
        ser.write(command.encode())
        time.sleep(1)
        print(ser.read_all().replace(b'\r\n', b'\n').decode("utf-8"))
    except Exception:
        pass

# Enable ADB
print("Attempting to enable ADB...")
write_and_read(ser, "AT+KSTRINGB=0,3\r\n")
write_and_read(ser, "AT+DUMPCTRL=1,0\r\n")
write_and_read(ser, "AT+DEBUGLVC=0,5\r\n")
write_and_read(ser, "AT+SWATD=0\r\n")
write_and_read(ser, "AT+ACTIVATE=0,0,0\r\n")
write_and_read(ser, "AT+SWATD=1\r\n")
write_and_read(ser, "AT+DEBUGLVC=0,5\r\n")
