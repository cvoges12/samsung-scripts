import serial
import time

port: String = "/dev/ttyACM0"
baudrate: Int = 115200
ser: Serial = serial.Serial(port, baudrate=baudrate)
print(f"Using port {port} set to {baudrate} baud...")

def write_and_read(ser: Serial, command: String):
    try:
        ser.write(command.encode())
        time.sleep(1)   # TODO: check when serial port
        print(ser.read_all().replace(b'\r\n', b'\n').decode("utf-8"))
    except Exception:
        pass

def enable_adb(ser: Serial):
    print("Attempting to enable ADB...")

    for command in [
        "AT+KSTRINGB=0,3\r\n",
        "AT+DUMPCTRL=1,0\r\n",
        "AT+SWATD=0\r\n",
        "AT+ACTIVATE=0,0,0\r\n",
        "AT+SWATD=1\r\n",
        "AT+DEBUGLVC=0,5\r\n"
    ]:
        write_and_read(ser, command)

enable_adb(ser)